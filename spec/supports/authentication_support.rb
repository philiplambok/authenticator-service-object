module AuthenticationSupport 
  def token_of(user)
    JWT.encode({user_id: user.id}, nil, 'none')
  end

  def auth_params(user)
    { auth: { username: user.username, password: user.password } }
  end

  def auth_header(user) 
    { authorization: "Bearer #{token_of(user)}" }
  end
end

RSpec.configure do |config|
  config.include AuthenticationSupport
end