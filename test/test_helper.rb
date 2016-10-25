ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def login_user(user)
    user = create(:user) if user
    session[:user_id] = user.id
    user
  end

  def current_user
    unless session[:user_id].nil?
      @login_user = User.find(session[:user_id]) unless @login_user
    end
  end

  def log_in?
    !session[:user_id].nil?
  end

end
