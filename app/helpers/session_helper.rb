module SessionHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
		!current_user.nil?
	end

  def log_out
		session.delete(:user_id)
		@current_user = nil
	end

  def current_user
    if request.content_type == 'application/json'
      authenticate_with_http_token do |token, _options|
            decode_token = (JWT.decode token, Rails.application.secrets['jwt_secret'], true, { :algorithm => Rails.application.secrets['jwt_algorithm'] })
            @current_user = User.find_by(decode_token[0]['user']['user_id'])
          end
          @current_user
    else
      if (user_id = session[:user_id])
  		    @current_user ||= User.find_by(id: user_id)
      end
    end
    # @current_user = User.find_by(id: request.headers["x-user-id"])
  end

end
