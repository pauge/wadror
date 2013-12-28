class RatingsController < ApplicationController
		def index
     	@ratings = Rating.all
		end
   
		def create
			rating = Rating.create params[:rating]
			current_user.ratings << rating
			redirect_to user_path(current_user)
		end
  
		def average_rating
  		b=self.ratings.average(:score)
			return b
		end
   
		def new
			@rating  = Rating.new
   		@beers = Beer.all
		end
   
		def destroy
			rating = Rating.find params[:id]
			rating.delete
			redirect_to ratings_path
   	end
end
