class PlacesController < ApplicationController

	def index
		
	end
	
	def search
		if not params[:city].eql?("")
				@places = BeermappingAPI.places_in(params[:city])
				if @places.empty?
					redirect_to places_path, :notice => "No locations in #{params[:city]}"
				else
					render :index
				end
		else
			redirect_to places_path, :notice => "Write a location"
		end
	end

end
