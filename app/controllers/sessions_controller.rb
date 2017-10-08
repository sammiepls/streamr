class SessionsController < ApplicationController
	# Handle Google OAuth 2.0 login callback

	# GET /auth/google_oauth2/callback
	def create
		auth_hash = request.env["omniauth.auth"]
		user = User.from_omniauth(auth_hash)

		if current_user

			user.update_token(auth_hash)

		else

			session[:user_id] = user.uid
			account = Yt::Account.new access_token: user.oauth_token
			flash[:success] = "Welcome, #{user.name}"

		end

			if session[:channel_id]
				redirect_to subscribe_path(session[:channel_id])
			else
			 	redirect_to root_path
			end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "Goodbye!"
		redirect_to root_path
	end

end
