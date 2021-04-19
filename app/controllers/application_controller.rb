class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  helper_method :current_user, :user_signed_in #讓helper也可以用得到底下定義的current_user、user_signed_in方法

  private
  def not_found
    render file: "#{Rails.root}/public/404.html", 
           status: 404
  end

  def current_user
    User.find_by(id: session[ENV['session_name']])
  end

  def user_signed_in?
    if session[ENV['session_name']]
      return true
    else
      return false
    end
  end

  def check_user
    if not user_signed_in?
      redirect_to root_path
    end
  end

end