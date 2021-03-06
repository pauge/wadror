class ApplicationController < ActionController::Base
  protect_from_forgery
	
	helper_method :current_user, :signed_in?

	def current_user
		return nil if session[:user_id].nil?
		User.find(session[:user_id])
	end

	def signed_in?(user)
		current_user == user
	end

	def ensure_that_signed_in
		redirect_to signin_path, :notice => 'You should sign in' if current_user.nil?
	end

	def is_admin
		redirect_to signin_path, :notice => 'You are not an admin, log in as one... If you can!' if current_user.nil? or not current_user.admin
	end

end
