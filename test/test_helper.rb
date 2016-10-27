ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def login_user(user = nil)
    @login_user = create(:user) unless user
    if integration_test?
      post login_path session: { name: @login_user.name, password: @login_user.password, password_confirmation: @login_user.password }
    else
      session[:user_id] = @login_user.id
    end
    @login_user
  end

  def current_user
    unless session[:user_id].nil?
      @login_user = User.find(session[:user_id])
    end
  end


  def log_in?
    !session[:user_id].nil?
  end

  def response_json
    ActiveSupport::JSON.decode @response.body
  end

  %w(get post delete put).each do |method|
    define_method "login_#{method}" do |action, *params|
      *params = params[0].merge headers: { HTTP_AUTHORIZATION: "Token token=#{@login_user.to_jwt}" }
      send method, action, *params
    end
  end

  private
    def integration_test?
      defined?(post_via_redirect)
    end

end
