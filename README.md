# Overview 
Sample project to implement service object that handle authentication. 

## Specs 
```
User
  valid with username, password and password_confirmation
  is invalid without username
  is invalid without password

Authentication API
  User sign in
    valid credential
      return token
    invalid credential
      return error response

Dashboard API
  User visit dashboard page
    authenticated user
      return success response
    unauthenticated user
      return errors response
    uncorrect format auth header
      return's errros response
    uncorrect auth token
      return's error response
```

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


## Source Code Service Object
### AuthService
-> `app/services/auth_service.rb`
```rb
class AuthService 
  attr_accessor :token, :user

  def initialize(options)
    @username = options[:username]
    @password = options[:password]
    @token = options[:token]
    @auth_header = options[:auth_header]

    setup
  end

  def setup
    @token = @auth_header.split[1] if auth_header_valid?

    set_token if @token.nil?
    set_user if @token
  end

  def auth_header_valid?
    return false unless @auth_header
    auth_header_arr = @auth_header.split
    return false if auth_header_arr.count != 2 
    return false if auth_header_arr[0] != "Bearer"
    true
  end

  private
  def set_token 
    @token = TokenService.generate(user_id: @user.id) if allow?
  end

  def set_user 
    @user = User.find_by(id: TokenService.new(token: @token).user_id)
  end

  def allow?
    @user = User.find_by(username: @username)
    if @user and @user.authenticate(@password)
      true
    else 
      false
    end
  end
end
```

### TokenService
-> `app/services/token_service.rb`
```ruby
class TokenService
  attr_accessor :token
  
  def initialize(options)
    @token = options[:token]
  end

  def self.generate(payload)
    JWT.encode(payload, nil, 'none')
  end

  def decode
    begin
      JWT.decode(@token, nil, false)
    rescue
      nil 
    end
  end

  def payload 
    decoded = decode
    decoded[0] if decode
  end

  def user_id
    payload["user_id"]
  end
end
```

## License 
Copyright 2018 Philip Lambok