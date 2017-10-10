class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  # def non_xhr_javascript_response?
  #   unless request.get?
  #     content_type =~ %r(\Atext/javascript) && !request.xhr?
  #   end
  # end

private



end
