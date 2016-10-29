class JsonAuthenticate

  def initialize(env)
    @env = env
  end

  def authenticate_token
    @env[authorization_key].split('=')[-1]
  end


  def vaild
    begin
      decode = JWT.decode authenticate_token, Rails.application.secrets['jwt_secret'], true, { :algorithm => Rails.application.secrets['jwt_algorithm'] }
      # { "x-user-id": decode[0]['user']['user_id'] }
      decode[0]['user']['user_id']
    rescue
      return unauthorize
    end
  end

  def authorization_key
    'HTTP_AUTHORIZATION'
  end

  def unauthorize
    [ 401,
      { 'Content-Type' => 'application/json'} ,
      ['{"error": "请登录"}']
    ]
  end

  def has_authorization_key?
    !@env[authorization_key].nil?
  end
end
