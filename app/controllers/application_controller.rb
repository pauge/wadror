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

end