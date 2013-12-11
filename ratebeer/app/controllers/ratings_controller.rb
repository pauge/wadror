class RatingsController < ApplicationController
   def index
     	@ratings = Rating.all
   end
   def create
	Rating.create params[:rating]
	redirect_to ratings_path
   end
   def new
	@rating  = Rating.new
   	@beers = Beer.all
   end
	
	
end
