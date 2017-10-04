class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def logged_in?
    session.has_key? :user_id
  end

  def current_user
    @current_user ||= User.find_by(uid: session[:user_id]) if logged_in?
  end
end