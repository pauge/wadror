class MembershipsController < ApplicationController

	def index
	end

	def new
		@membership = Membership.new
	end

	def create
		i = Integer(params[:membership][:beer_club_id])
		if 	current_user.memberships.find(:all, :conditions => {:beer_club_id => i}, :limit => 2).count > 0		
				redirect_to :back, :notice => "Already a member of that club"
		else
			Membership.create params[:membership] 
			redirect_to user_path(current_user)
		end
	end

end
