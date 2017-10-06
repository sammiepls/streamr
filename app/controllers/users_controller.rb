class UsersController < ApplicationController

  def create

    redirect_to root_path

  end

  def subscribe

    session[:channel_id] = subscribe_params[:channel_id]

    if !(current_user)
      redirect_to login_path and return
    else
		  account = Yt::Account.new access_token: current_user.oauth_token
      channel = Yt::Channel.new id: session[:channel_id], auth: account
        if channel.subscribed? == false
          channel.subscribe
        end
    end

    session[:channel_id] = nil
    redirect_to root_path

  end

  def subscribe_params

    params.permit(:channel_id)

  end

  def authorization_params

		params.permit(:code)

	end

  def initialize_user

    Yt::Account.new(scopes: ["youtube"], redirect_uri: ENV['GOOGLE_REDIRECT_URIS']).authentication_url
    sessions_controller = SessionsController.new
    sessions_controller.create

  end
end
