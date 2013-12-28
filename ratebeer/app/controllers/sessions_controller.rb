class SessionsController < ApplicationController
	def new
		#render login screen
	end

	def create
		#get user from DB
		user = User.find_by_username params[:username]
		
		#save the ID of user to session, if it exists
		session[:user_id] = user.id if not user.nil?
		redirect_to user_path(user)
	end

	def destroy
		#clear session
		session[:user_id] = nil
		#redirect to main page
		redirect_to :root
	end

end
