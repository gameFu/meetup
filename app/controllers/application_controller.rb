class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protect_from_forgery  unless: -> { request.format.json? }
  include SessionHelper


end
