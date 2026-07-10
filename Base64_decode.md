# https://macedomauriz.com/blog/deploy-multi-line-docker-compose-files-to-ec2-github-actions-ssm/


```bash
- name: Deploy Test Stack (Base64 Method)
      run: |
        set -e
        
        # 1. Define the YAML clearly
        COMPOSE_YAML="services:
          hello-world-app:
            image: hello-world
            container_name: hello_container
          nginx-webserver:
            image: nginx:latest
            container_name: nginx_container
            ports:
              - \"8080:80\""

        # 2. Encode it to a single line of Base64
        B64_COMPOSE=$(echo "$COMPOSE_YAML" | base64 -w 0)

        # 3. Create the JSON for SSM
        COMMANDS_JSON=$(jq -n --arg b64 "$B64_COMPOSE" \
        '{commands: [
            "mkdir -p ~/test-app",
            "cd ~/test-app",
            "echo \($b64) | base64 -d > docker-compose.yml",
            "echo \"--- File Content Verification ---\"",
            "cat docker-compose.yml",
            "sudo docker-compose pull",
            "sudo docker-compose up -d --remove-orphans",
            "sleep 5",
            "sudo docker ps -a"
        ]}')

        CMD_ID=$(aws ssm send-command \
          --document-name "AWS-RunShellScript" \
          --instance-ids "$EC2_INSTANCE_ID" \
          --parameters "$COMMANDS_JSON" \
          --output text --query "Command.CommandId")

        echo "Command ID: $CMD_ID"

        # Polling Loop
        for i in $(seq 1 36); do
          STATUS=$(aws ssm get-command-invocation --command-id "$CMD_ID" --instance-id "$EC2_INSTANCE_ID" --query "Status" --output text 2>/dev/null || echo "Pending")
          echo "Deploy status: $STATUS"
          [ "$STATUS" = "Success" ] && break
          [[ "$STATUS" == "Failed" || "$STATUS" == "TimedOut" || "$STATUS" == "Cancelled" ]] && exit 1
          sleep 10
        done

        echo "--- EC2 Execution Output ---"
        aws ssm get-command-invocation --command-id "$CMD_ID" --instance-id "$EC2_INSTANCE_ID" --query "StandardOutputContent" --output text
```