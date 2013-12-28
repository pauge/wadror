class RatingsController < ApplicationController
   def index
     	@ratings = Rating.all
   end
   
	 def create
		Rating.create params[:rating]
		session[:last_rating]= "#{Beer.find(params[:rating][:beer_id])} #{params[:rating][:score]} points"
  def average_rating

  	b=self.ratings.average(:score)
	return b
  end
		redirect_to ratings_path
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
