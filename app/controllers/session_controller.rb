class SessionController < ApplicationController


  def new
  end

  def create
    @user = User.find_by(name: params[:session][:name].downcase)
  	if @user && @user.authenticate(params[:session][:password])
    		log_in @user

        respond_to do |format|
          format.html {
            redirect_to root_url
          }
          format.json {
            render json: { jwt: @user.to_jwt }
          }
        end
  	else
  		# 错误信息闪现 .now方法是在render重新渲染专用的闪现方法 可以避免闪现消息在跳转其他页面时不消失的bug
      respond_to do |format|
        format.html {
          flash.now[:danger] = '账号/密码错误'
      		render 'new'
        }
        format.json {
          render json: { error: '账号密码错误'}, status: 403
        }
      end
  	end
  end


  def destroy
    log_out if logged_in?
  	redirect_to root_url
  end



end
