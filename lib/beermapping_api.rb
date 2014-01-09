class BeermappingAPI


	def self.places_in city
		url = "http://beermapping.com/webservice/loccity/#{self.key}/"
		
		response = HTTParty.get "#{url}#{city.gsub(' ', '%20')}"
		places = response.parsed_response["bmp_locations"]["location"]
		
		return [] if places.is_a?(Hash) and places['id'].nil?
			
		places = [places] if places.is_a?(Hash)
		@places = places.inject([])  do |set, place|
				set << Place.new(place)
		end
	end


	def self.key
		api_key = "78f7ce0c9393a60a0626aac387221219"
	end


end

