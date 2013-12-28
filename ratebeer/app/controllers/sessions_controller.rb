class SessionsController < ApplicationController
	def new
		#render login screen
	end

	def create
		#get user from DB
		user = User.find_by_username params[:username]
	
		if user.nil?
				redirect_to :back, :notice => "User #{params[:username]} does not exist!"
		else
		#save the ID of user to session, if it exists
		session[:user_id] = user.id
		redirect_to user_path(user), :notice => "Welcome back!"
		end
	end

	def destroy
		#clear session
		session[:user_id] = nil
		#redirect to main page
		redirect_to :root
	end

end
