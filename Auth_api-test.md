# GIV Society Authentication API — Postman Testing Guide

This guide will help you test the GIV Society authentication API using [Postman](https://www.postman.com/). It includes:
- Step-by-step instructions
- Example requests and responses
- A ready-to-import Postman collection for all endpoints

---

## 1. **Getting Started**

- Make sure your backend server is running:
  ```sh
  npm start
  ```
- The API base URL is: `http://localhost:3000/api/v1/auth`
- Download and install [Postman](https://www.postman.com/downloads/) if you haven't already.

---

## 2. **Endpoints Covered**
- `POST   /register` — Register a new user
- `POST   /login` — Login and get tokens
- `GET    /me` — Get current user profile
- `POST   /refresh` — Refresh access token
- `PUT    /change-password` — Change password
- `POST   /request-password-reset` — Request password reset
- `POST   /reset-password` — Reset password with token
- `PUT    /profile` — Update user profile
- `DELETE /account` — Delete user account
- `GET    /health` — Health check

---

## 3. **How to Use the Postman Collection**

1. **Copy the JSON below** (from the code block) to your clipboard.
2. In Postman, click **Import** > **Raw Text** > paste the JSON > **Continue** > **Import**.
3. The collection "GIV Society Auth API" will appear in your workspace.
4. Set the `{{baseUrl}}` variable to `http://localhost:3000/api/v1/auth` (or your deployed URL).
5. Use the requests in order. For protected endpoints, set the `accessToken` variable after login.

---

## 4. **Ready-to-Import Postman Collection**

```json
{
  "info": {
    "_postman_id": "giv-society-auth-api-collection",
    "name": "GIV Society Auth API",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "variable": [
    { "key": "baseUrl", "value": "http://localhost:3000/api/v1/auth" },
    { "key": "accessToken", "value": "" },
    { "key": "refreshToken", "value": "" }
  ],
  "item": [
    {
      "name": "Register",
      "request": {
        "method": "POST",
        "header": [ { "key": "Content-Type", "value": "application/json" } ],
        "body": {
          "mode": "raw",
          "raw": "{\n  \"full_name\": \"Test User\",\n  \"email\": \"testuser@example.com\",\n  \"password\": \"TestPassword123!\",\n  \"role\": \"volunteer\",\n  \"language_preference\": \"en\"\n}"
        },
        "url": { "raw": "{{baseUrl}}/register", "host": [ "{{baseUrl}}" ], "path": [ "register" ] }
      },
      "response": []
    },
    {
      "name": "Login",
      "event": [
        {
          "listen": "test",
          "script": {
            "exec": [
              "// Save tokens to variables",
              "if (pm.response.code === 200) {",
              "  var data = pm.response.json();",
              "  pm.collectionVariables.set('accessToken', data.tokens.accessToken);",
              "  pm.collectionVariables.set('refreshToken', data.tokens.refreshToken);",
              "}"
            ],
            "type": "text/javascript"
          }
        }
      ],
      "request": {
        "method": "POST",
        "header": [ { "key": "Content-Type", "value": "application/json" } ],
        "body": {
          "mode": "raw",
          "raw": "{\n  \"email\": \"testuser@example.com\",\n  \"password\": \"TestPassword123!\"\n}"
        },
        "url": { "raw": "{{baseUrl}}/login", "host": [ "{{baseUrl}}" ], "path": [ "login" ] }
      },
      "response": []
    },
    {
      "name": "Get Profile (me)",
      "request": {
        "method": "GET",
        "header": [ { "key": "Authorization", "value": "Bearer {{accessToken}}" } ],
        "url": { "raw": "{{baseUrl}}/me", "host": [ "{{baseUrl}}" ], "path": [ "me" ] }
      },
      "response": []
    },
    {
      "name": "Refresh Token",
      "event": [
        {
          "listen": "test",
          "script": {
            "exec": [
              "// Save new tokens to variables",
              "if (pm.response.code === 200) {",
              "  var data = pm.response.json();",
              "  pm.collectionVariables.set('accessToken', data.tokens.accessToken);",
              "  pm.collectionVariables.set('refreshToken', data.tokens.refreshToken);",
              "}"
            ],
            "type": "text/javascript"
          }
        }
      ],
      "request": {
        "method": "POST",
        "header": [ { "key": "Content-Type", "value": "application/json" } ],
        "body": {
          "mode": "raw",
          "raw": "{\n  \"refreshToken\": \"{{refreshToken}}\"\n}"
        },
        "url": { "raw": "{{baseUrl}}/refresh", "host": [ "{{baseUrl}}" ], "path": [ "refresh" ] }
      },
      "response": []
    },
    {
      "name": "Change Password",
      "request": {
        "method": "PUT",
        "header": [
          { "key": "Content-Type", "value": "application/json" },
          { "key": "Authorization", "value": "Bearer {{accessToken}}" }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\n  \"current_password\": \"TestPassword123!\",\n  \"new_password\": \"NewPassword123!\",\n  \"confirm_password\": \"NewPassword123!\"\n}"
        },
        "url": { "raw": "{{baseUrl}}/change-password", "host": [ "{{baseUrl}}" ], "path": [ "change-password" ] }
      },
      "response": []
    },
    {
      "name": "Request Password Reset",
      "request": {
        "method": "POST",
        "header": [ { "key": "Content-Type", "value": "application/json" } ],
        "body": {
          "mode": "raw",
          "raw": "{\n  \"email\": \"testuser@example.com\"\n}"
        },
        "url": { "raw": "{{baseUrl}}/request-password-reset", "host": [ "{{baseUrl}}" ], "path": [ "request-password-reset" ] }
      },
      "response": []
    },
    {
      "name": "Reset Password",
      "request": {
        "method": "POST",
        "header": [ { "key": "Content-Type", "value": "application/json" } ],
        "body": {
          "mode": "raw",
          "raw": "{\n  \"token\": \"<resetToken>\",\n  \"newPassword\": \"ResetPassword123!\"\n}"
        },
        "url": { "raw": "{{baseUrl}}/reset-password", "host": [ "{{baseUrl}}" ], "path": [ "reset-password" ] }
      },
      "response": []
    },
    {
      "name": "Update Profile",
      "request": {
        "method": "PUT",
        "header": [
          { "key": "Content-Type", "value": "application/json" },
          { "key": "Authorization", "value": "Bearer {{accessToken}}" }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\n  \"full_name\": \"Updated Test User\"\n}"
        },
        "url": { "raw": "{{baseUrl}}/profile", "host": [ "{{baseUrl}}" ], "path": [ "profile" ] }
      },
      "response": []
    },
    {
      "name": "Delete Account",
      "request": {
        "method": "DELETE",
        "header": [ { "key": "Authorization", "value": "Bearer {{accessToken}}" } ],
        "url": { "raw": "{{baseUrl}}/account", "host": [ "{{baseUrl}}" ], "path": [ "account" ] }
      },
      "response": []
    },
    {
      "name": "Health Check",
      "request": {
        "method": "GET",
        "url": { "raw": "{{baseUrl}}/health", "host": [ "{{baseUrl}}" ], "path": [ "health" ] }
      },
      "response": []
    }
  ]
}
```

---

## 5. **Tips for Testing**
- **Register** a new user first. If you get a "User already exists" error, change the email.
- **Login** to get your `accessToken` and `refreshToken` (they are saved as variables automatically).
- For protected endpoints, the `Authorization` header is set automatically using `{{accessToken}}`.
- To test password reset, use the reset token from the response of the request password reset endpoint.
- You can duplicate requests and change values to test edge cases.

---

## 6. **Troubleshooting**
- If you get a 401 error, make sure your `accessToken` is up to date (login again if needed).
- If you change the password, login again to get new tokens.
- If you restart the server, you may need to login again.

---

Happy testing! 🎉 
