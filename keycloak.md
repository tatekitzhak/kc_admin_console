# Client Keycloak
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
- Root URL: `http://localhost:5173` - The base URL of your application.
- Home URL: `http://localhost:5173`- Where the auth server redirects users if they click a "Back to Application" link.
- Valid redirect URIs: `http://localhost:5173/*` - Crucial. The specific paths where the auth server is allowed to send the login response. The wildcard * allows for various routes.
- Valid post logout redirect URIs: `http://localhost:5173/*` - Where the user is sent after logging out.
- Web origins: `http://localhost:5173` - This enables CORS. It allows your React app's domain to make JavaScript requests to the auth server.



# User
- https://www.youtube.com/watch?v=fvxQ8bW0vO8
- Test application: `https://www.keycloak.org/app/`
- acces to user: `https://<keycloak-host>/realms/<realm-name>/account`
- https://3.135.234.65:8443/admin/realms/master/users
- https://3.135.234.65:8443/realms/themelinx/.well-known/openid-configuration

# Error
- https://localhost:8443/realms/localhost_realm/.well-know/openid-configuration

https://www.keycloak.org/app/?url=https://localhost:8443&realm=`[realm_name]`&client=`[client_name]`

# Keycloak a comprehensive Admin REST API for managing and configurations programmatically.
- https://www.keycloak.org/docs-api/latest/rest-api/index.html


# keycloak single sign on
- login forms
- user Authentication
- storing user

# Tutor
- https://darkaico.medium.com/building-a-secure-authentication-system-with-keycloak-react-and-flask-35aeee04e37a


# Access
- https://localhost:844