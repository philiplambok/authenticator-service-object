# Overview 
Sample project to implement service object that handle authentication. 

## Specs 
- Service object can check credential of authentication parameter. 
- Service object can return token if credential is valid. 
- Service object can return user object from token input. 

## Enpoints 
### Sign in
- URL
  - POST /auth
- PARAMS
  - `{ auth: {username: "username", password: "password" } }`
- Success Response 
  - `{ jwt: "auth_token_here" }`
- Error Response 
  - `{ error: { message: "Sorry, the credential is invalid"  } }`

### Dashboard 
- URL
  - GET /dashboard
- PARAMS
  - none
- Success Response 
  - `{success: {message: "Welcome to dashboard, #{username}}`
- Error Response 
  - `{error: {message: "Sorry, you're not authenticated"}}`

## License 
Copyright 2018 Philip Lambok