class SessionsController < ApplicationController
	# Handle Google OAuth 2.0 login callback

	# GET /auth/google_oauth2/callback
	def create
		byebug
		if current_user

			current_user.update_token

		else

		auth_hash = request.env["omniauth.auth"]
		user = User.from_omniauth(auth_hash)
		session[:user_id] = user.id
		account = Yt::Account.new access_token: user.oauth_token

		end

			flash[:success] = "Welcome, #{user.name}"

			if session[:channel_id]
				redirect_to subscribe_path(session[:channel_id])
			else
			 	redirect_to root_path
			end
	end

	def destroy
		session[:user_id] = nil
		session[:channel_id] = nil
		flash[:success] = "Goodbye!"
		redirect_to root_path
	end

end
