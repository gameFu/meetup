require_relative 'authenticate_user/json'
require_relative 'authenticate_user/html'


class AuthenticateUserRequest

  def initialize(app)
    @app = app
    @user_header = {}
  end

  def call(env)
    @env = env
    if not_authenticate_request?
      if json_request?
        authenticate = JsonAuthenticate.new(@env)
      else
        authenticate = HtmlAuthenticate.new(@env)
      end
      return authenticate.unauthorize unless authenticate.has_authorization_key?

      @user_header = authenticate.vaild
    end
    @app.call(@env)

  end

  def json_request?
    @env['CONTENT_TYPE'] == 'application/json'
  end

  def not_authenticate_request?
    !(['/login', '/login.json', '/', '/signup'].include?(@env['PATH_INFO']) || @env['PATH_INFO'] =~ /\/assets\/+/ )
  end


end
