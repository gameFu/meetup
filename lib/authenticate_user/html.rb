class HtmlAuthenticate

  def initialize(env)
    @env = env
  end

  def authenticate_token
    @env['rack.session'][:user_id]
  end


  def vaild
    return unauthorize unless User.exists? authenticate_token
    # { "x-user-id": authenticate_token }
    authenticate_token
  end

  def unauthorize
     [301, {'Location' => '/login', 'Content-Type' => 'text/html', 'Content-Length' => '0'}, []]
  end

  def has_authorization_key?
    !@env['rack.session'][:user_id].nil?
  end

end
