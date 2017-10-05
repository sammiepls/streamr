class UsersController < ApplicationController

  # def create
  #   @user_authentication = Yt::Account.new(scopes: 'userinfo.email', redirect_uri: ENV['GOOGLE_REDIRECT_URIS']).authentication_url
  #   # @user = User.new(email, etc)
  #   redirect_to root_path
  # end

  def subscribe
byebug
  #channel to subscribe
    @channel_id = subscribe_params
  #subscriber
    @account = Yt::Account.new access_token:  current_user.oauth_token
  #subscribe!
    @channel = Yt::Channel.new id: 'UCxO1tY8h1AhOz0T4ENwmpow', auth: @account
    @channel.subscribe

  end

  def subscribe_params

    params.permit(:channel_id)

  end

end
