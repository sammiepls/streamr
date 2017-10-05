class SessionsController < ApplicationController
	# Handle Google OAuth 2.0 login callback.
	#
	# GET /auth/google_oauth2/callback
	def create
		user = User.from_omniauth(request.env["omniauth.auth"])
		session[:user_id] = user.uid
		redirect_to root_path
	end

	def destroy
		session[:user_id] = nil

		redirect_to root_path
	end
end
