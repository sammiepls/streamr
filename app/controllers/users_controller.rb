class UsersController < ApplicationController

  def create

    redirect_to root_path

  end

  def subscribe
  #channel to subscribe
    @channel_id = subscribe_params[:channel_id]
  #subscriber
    @account = Yt::Account.new access_token:  current_user.oauth_token
    byebug
  #subscribe!
    @channel = Yt::Channel.new id: @channel_id, auth: @account
    @channel.subscribe
    # 'UCxO1tY8h1AhOz0T4ENwmpow'
  end

  def subscribe_params

    params.permit(:channel_id)

  end

end
