require_relative 'authenticate_user/json'
require_relative 'authenticate_user/html'


class AuthenticateUserRequest

  def initialize(app)
    @app = app
    @user_id = 0
  end

  def call(env)
    @env = env
    if not_authenticate_request?
      authenticate = json_request? ? JsonAuthenticate.new(@env) : HtmlAuthenticate.new(@env)
      return authenticate.unauthorize unless authenticate.has_authorization_key?

      @user_id = authenticate.vaild
    end
    @env['X-USER-ID'] = @user_id
    @app.call(@env)

  end

  def json_request?
    @env['CONTENT_TYPE'] == 'application/json'
  end

  def not_authenticate_request?
    !(['/login', '/login.json', '/', '/signup'].include?(@env['PATH_INFO']) || @env['PATH_INFO'] =~ /\/assets\/+/ )
  end


end
