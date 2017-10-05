class SessionsController < ApplicationController
	# Handle Google OAuth 2.0 login callback.
	#

	# GET /auth/google_oauth2/callback
	def create
		auth_hash = request.env['omniauth.auth']
		user = User.from_omniauth(request.env['omniauth.auth'])
   		session[:user_id] = user.id
   		flash[:success] = "Welcome, #{user.name}"

      	if user.oauth_token
		    user.update_token(auth_hash)
		end
		user = User.from_omniauth(request.env["omniauth.auth"])
		session[:user_id] = user.uid
		@account = Yt::Account.new access_token: user.oauth_token
		@live_id = @account.channel.videos.where(type: 'video', eventType:'live').first.id
		flash[:success] = "Welcome, #{user.name}"
		
		redirect_to root_path
		user = User.from_omniauth(request.env["omniauth.auth"])
		session[:user_id] = user.uid
		@account = Yt::Account.new access_token: user.oauth_token
		byebug
		redirect_to root_path
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "Goodbye!"
		redirect_to root_path
	end
end
