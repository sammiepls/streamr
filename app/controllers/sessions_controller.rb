class SessionsController < ApplicationController
	# Handle Google OAuth 2.0 login callback.
	#
	# GET /auth/google_oauth2/callback
	def create

		auth_hash = request.env['omniauth.auth']
		user = User.from_omniauth(request.env['omniauth.auth'])
   	session[:user_id] = user.id
   	flash[:success] = "Welcome, #{user.name}"

      if user.token
		    user.update_token(auth_hash)
		  end

		    #  @account = Yt::Account.new access_token: user.token
		    #  @channel = Yt::Channel.new id: @account.channel.id, auth: @account
		    #  redirect_to root_url(@account, @channel)
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "Goodbye!"
		redirect_to root_path
	end
end
