class SessionController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(name: params[:session][:name].downcase)
  	if @user && @user.authenticate(params[:session][:password])
    		log_in @user
    		redirect_to root_url
  	else
  		# 错误信息闪现 .now方法是在render重新渲染专用的闪现方法 可以避免闪现消息在跳转其他页面时不消失的bug
  		flash.now[:danger] = '邮箱/密码错误'
  		render 'new'
  	end
  end



end
