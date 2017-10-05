class UsersController < ApplicationController

  def create

    redirect_to root_path

  end

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
