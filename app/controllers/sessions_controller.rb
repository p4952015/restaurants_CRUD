class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.login(user_params)
    if user
      # 發號碼牌
      session[ENV['session_name']] = user.id #session會存在cookies裡
      # 轉去首頁
      redirect_to root_path
    else
      redirect_to sign_in_sessions_path
    end
  end

  def destroy
    session[ENV['session_name']] = nil #把session改成nil(撕掉號碼牌)
    redirect_to root_path
  end


  private
  def user_params
    params.require(:user).permit(:email, :password)
  end


end