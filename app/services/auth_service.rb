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