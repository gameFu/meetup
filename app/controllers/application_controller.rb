class ApplicationController < ActionController::Base
  # self.responder = ApplicationResponder
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protect_from_forgery  unless: -> { request.format.json? }
  include SessionHelper

  before_action :logged_in_user

  def logged_in_user
    unless logged_in?
      respond_to do |format|
        format.html {
          flash[:danger] = '请登录'
          redirect_to login_path
        }
        format.json {
          render json: { error: '请登录'}, status: 403
        }
      end
    end
  end

end
