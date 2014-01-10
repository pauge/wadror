require 'spec_helper'

	describe "BeermappingAPI" do

		it "when HTTP GET returns one entry, it is parsed and returned" do
		s = <<-END_OF_STRING
			<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>13307</id><name>O'Connell's Irish Bar</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13307</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap><street>Rautatienkatu 24</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227032</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>	
			END_OF_STRING
			
			stub_request(:get, /,*/).to_return(:body => s, :headers => {'Content-Type' => "text/xml" })

			places = BeermappingAPI.places_in("helsinki")

			expect(places.size).to eq(1)
			place = places.first
			expect(place.name).to eq("O'Connell's Irish Bar")
			expect(place.street).to eq("Rautatienkatu 24")
		end

		it "when HTTP GET returns no entries, the user is notified" do
			s = <<-END_OF_STRING
			<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>
			END_OF_STRING

			stub_request(:get, /,*/).to_return(:body => s, :headers => {'Content-Type' => "text/xml" })
			
			places = BeermappingAPI.places_in("kuortane")

			expect(places.size).to eq(0)
		end

		it "when HTTP GET returns multiple entries, they are all shown" do
			s = <<-END_OF_STRING

			<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>18098</id><name>Panimoravintola Beer Hunter's</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=18098</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18098&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18098&amp;d=1&amp;type=norm</blogmap><street>Antinkatu 11</street><city>Pori</city><state></state><zip>28100</zip><country>Finland</country><phone>+358 2 6415599</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>18149</id><name>Ravintola Kirjakauppa</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=18149</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18149&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18149&amp;d=1&amp;type=norm</blogmap><street>Antinkatu 10</street><city>Pori</city><state></state><zip>29100</zip><country>Finland</country><phone>045 358 77 93</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
			END_OF_STRING

			stub_request(:get, /,*/).to_return(:body => s, :headers => {'Content-Type' => "text/xml" })

			places = BeermappingAPI.places_in("pori")

			expect(places.size).to eq(2)
			place1 = places.first
			expect(place1.name).to eq("Panimoravintola Beer Hunter's")
			expect(place1.street).to eq("Antinkatu 11")
			
			place2 = places.last
			expect(place2.name).to eq("Ravintola Kirjakauppa")
			expect(place2.street).to eq("Antinkatu 10")


		end
	end
