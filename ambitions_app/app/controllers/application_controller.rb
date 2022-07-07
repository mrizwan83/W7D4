class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_current_user
    redirect_to new_user_url unless current_user
  end

  def require_no_current_user
    redirect_to root_url if current_user
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def require_logged_out
    redirect_to users_url if logged_in?
  end

  def log_in_user(user)
    session[:session_token] = user.reset_session_token
  end

  def logged_in?
    !!current_user
  end

  def log_out_user
    current_user.reset_session_token
    session[:session_token] = nil
    @current_user = nil 
  end

end
