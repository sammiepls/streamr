class UsersController < ApplicationController


  def create
    @user_authentication = Yt::Account.new(scopes: 'userinfo.email', redirect_uri: ENV['GOOGLE_REDIRECT_URIS']).authentication_url
    # @user = User.new(email, etc)
    redirect_to root_path
  end

  def subscribe
    session[:channel_id] = subscribe_params[:channel_id]

    if !(current_user)

      # redirect_to login_path and return
      respond_to do |format|

        format.js { render js: "window.location = '#{login_path}'"}
        # format.html { redirect_to login_path and return}
      end
      # redirect_to login_path, format: 'js'
    else

    current_user.update_token
		  account = Yt::Account.new access_token: current_user.oauth_token
        channel = Yt::Channel.new id: session[:channel_id], auth: account
        if channel.subscribed? == false
          channel.subscribe
          flash[:success] = "Successfully subscribed to channel."
        elsif channel.subscribed? == true
          flash[:error] = "Already subscribed to channel."
        end

        respond_to do |format|
          format.js
          format.html { redirect_to root_path }
        end
    # session[:channel_id] = nil
    # redirect_to root_path
    end
  end

  def subscribe_params

    params.permit(:channel_id)
  end

  def authorization_params

		params.permit(:code)
  end

end
