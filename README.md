# Keycloak - Authentication and access management platforms, Identity and Access Management (IAM) tools 

****** Tutor
** https://dorokhovich.com/blog/keycloak-nginx-cluster
** https://www.youtube.com/watch?v=Kv3hhuyrpXg
** https://www.keycloak.org/server/reverseproxy
** https://rogitel.com/keycloak-installing-with-nginx-troubleshooting/s
******

*******************************************************************
#   How to Configuration and Run the project on AWS EC2 server:  **
*******************************************************************
# How to Configuration and Run the project on AWS EC2 server:

Access to Keycloack admin console app:
- https://[IP OR DOMAIN_NAME]:8443
- https://18.117.180.32:8443/admin/master/console/

RUN folder files: /home/ubuntu/kc-app-https

1.  Modify an `.env` file is compatible correctly against Production
2. `docker network create kc_shared_central_nginx_proxy_network`

3. SSL
- Go to directory: `nginx/certs/` and run:
```bash
***** IF LOCALHOST ****

openssl req -x509 -out localhost.crt -keyout localhost.key \
  -newkey rsa:2048 -nodes -sha256 -days 365 \
  -subj "/CN=18.221.18.219" -extensions EXT -config <( \
   printf "[dn]\nCN=18.221.18.219\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=IP:18.221.18.219\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")

***** IF PROD ****
openssl req -x509 -out prod.crt -keyout prod.key \
  -newkey rsa:2048 -nodes -sha256 -days 365 \
  -subj "/CN=18.117.180.32" -extensions EXT -config <( \
   printf "[dn]\nCN=18.117.180.32\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=IP:18.117.180.32\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
  ```

# Keycloak Server Admin
1. Update `docker-compose.yml` file
- KC_HOSTNAME_ADMIN_URL: https://[IP_ADDR_OR_DOMAIN_NAME]:8443
- KC_HOSTNAME_URL: https://[IP_ADDR_OR_DOMAIN_NAME]:8443

4. npm artifacts
- `npm run clean`
- `npm run build`

7. Deploy on EC2: `docker pull [repository_name]:[version]`
- To validate if your image has created: `docker images`
- Run container:
```bash
docker run -d \
--name abcd \
-p 4000:443 \
ranitzahak/tr-kc-spindraw-img:v1
```

8. Flush Docker's Host Sockets:
- `docker compose down`
- `docker compose up -d`
9. Check if the Ports are Actually Bound Live-
    Run a network status check command to verify that ports 80 and 443 are actively listening on the host framework:
- ` sudo ss -tulnp | grep -E ':80|:443' `

- To list the running container: `docker ps`



# Keycloak Admin Console
- Create realm
- Create client - Login settings:
1. Root URL:`https://[domain_name]:4000` - The base URL of your application.
2. Home URL:`https://[domain_name]:4000`- Where the auth server redirects users if they click a "Back to Application" link.
3. Valid redirect URIs:`https://[domain_name]:4000/*` - Crucial. The specific paths where the auth server is allowed to send the login response. The wildcard * allows for various routes.
4. Valid post logout redirect URIs:`https://[domain_name]:4000/*` - Where the user is sent after logging out.
5. Web origins: `https://[domain_name]:4000` - This enables CORS. It allows your React app's domain to make JavaScript requests to the auth server.
- Create user: 


3. Client Keycloak
- The client account is represents an application or service that trusts Keycloak to authenticate users or authenticate itself.
- Clients are applications and services that can request authentication of a user:

```bash
Root URL: 
Home URL:
Valid redirect URIs:
Valid post logout redirect URIs:
Web origins:
```

  Field,     Value,                    Description
- Root URL: `https://localhost:4000` - The base URL of your application.
- Home URL: `https://localhost:5173`- Where the auth server redirects users if they click a "Back to Application" link.
- Valid redirect URIs: `https://localhost:5173/*` - Crucial. The specific paths where the auth server is allowed to send the login response. The wildcard * allows for various routes.
- Valid post logout redirect URIs: `https://localhost:5173/*` - Where the user is sent after logging out.
- Web origins: `https://localhost:5173` - This enables CORS. It allows your React app's domain to make JavaScript requests to the auth server.

   

## Keycloak handles : Single Sign On

## Single Log Out

## login with social networks 
1. User tries to access the secure reactjs application 
2. Then user is redirected to the Keyclock server 
3. User authentication against Keyclock server
4. User is redirected back to the client application (reactjs) 

- Google 
- GitHub 
- Facebook 
- LinkedIn

## User Federation
- DataBase User Table
- NoSQL 

clean docker:
- sudo docker-compose down
- sudo docker system prune -f

run docker:
- sudo docker-compose up -d --remove-orphans
- sudo docker ps
- sudo docker exec ee3d31555276 curl -v http://localhost:8080

docker util:

find containrs ID:
- sudo docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"

Install vim:
-  sudo docker exec -u 0 -it f25d80c2dd30 sh -c "apk add vim"

Logs:
- docker logs -f keycloak


## To create an OIDC identity provider (IdP) in AWS and specify its audience for GitHub (AWS CLI)
- Provider URL (Issuer URL): `https://token.actions.githubusercontent.com`
- Audience (Client ID): `sts.amazonaws.com`
- `https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/`

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::<Account ID>:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:sub": "repo:Ran-Itzhack/terraform_and_gitHub_action_workflows:ref:refs/heads/<ExampleBranch>",
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
```

```bash
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::<Account ID>:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                },
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "repo:<BRANCH_NAME>/<REPOSITORY_NAME>:*"
                }
            }
        }
    ]
}
```

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Principal": {
                "Federated": "arn:aws:iam::937325632884:oidc-provider/token.actions.githubusercontent.com"
            },
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:aud": [
                        "sts.amazonaws.com"
                    ]
                },
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": [
                        "repo:tatekitzhak/kc_admin_console:*",
                        "repo:tatekitzhak/kc_admin_console:*"
                    ]
                }
            }
        }
    ]
}