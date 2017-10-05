class UserController < ApplicationController

  def create
    byebug
    @user_authentication = Yt::Account.new(scopes: 'userinfo.email', redirect_uri: ENV['YT_REDIRECT_URIS']).authentication_url
    # @user = User.new(email, etc)
    redirect_to root_path

  end

end
