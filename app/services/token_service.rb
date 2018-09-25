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
    decode[0] if decode
  end

  def user_id
    payload["user_id"]
  end
end