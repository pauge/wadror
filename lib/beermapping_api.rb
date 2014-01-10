class BeermappingAPI

	def self.bar id
		Place #load the class
		response= HTTParty.get "http://beermapping.com/webservice/locquery/#{key}/#{id}"
		bar = response.parsed_response["bmp_locations"]["location"]	
	
		return bar
	end

	def self.bar_points id
		Place
		response= HTTParty.get "http://beermapping.com/webservice/locscore/#{key}/#{id}"
		points =response.parsed_response["bmp_locations"]["location"]

		return points
	end
	
	def self.places_in city
		Place #to ensure that the class is loaded
		city = city.downcase
		Rails.cache.write city, fetch_places_in(city), expires_in: 600.seconds if not Rails.cache.exist? city

		Rails.cache.read city
	end

	def self.fetch_places_in city
		url = "http://beermapping.com/webservice/loccity/#{key}/"
		
		response = HTTParty.get "#{url}#{city.gsub(' ', '%20')}"
		places = response.parsed_response["bmp_locations"]["location"]
		return [] if places.is_a?(Hash) and places['id'].nil?
			
		places = [places] if places.is_a?(Hash)
		@places = places.inject([])  do |set, place|
				set << Place.new(place)
		end
	end


	def self.key
		Settings.beermapping_apikey
	end


end

