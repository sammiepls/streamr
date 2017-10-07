class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # def non_xhr_javascript_response?
  #   unless request.get?
  #     content_type =~ %r(\Atext/javascript) && !request.xhr?
  #   end
  # end

private

  def logged_in?
    session.has_key? :user_id
  end

  def current_user
    @current_user ||= User.find_by(uid: session[:user_id]) if session[:user_id]
  end

  helper_method :logged_in?, :current_user

end
