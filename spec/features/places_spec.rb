require 'spec_helper'

	describe "Places" do
=begin
		it "if one is returned by the API, it is shown at the page" do
			BeermappingAPI.stub(:places_in).with("kumpula").and_return( [Place.new(:name => "Oljenkorsi")])

			visit places_path
			fill_in('city', :with => 'kumpula')
			click_button "Search"

			expect(page).to have_content "Oljenkorsi"
		end
		
		it "if more than one is returned by the API, all are shown at the page" do
			BeermappingAPI.stub(:places_in).with("kumpula").and_return( [Place.new(:name => "Oljenkorsi"), Place.new(:name => "Karin kellarikomero")])

			visit places_path
			fill_in('city', :with => 'kumpula')
			click_button "Search"

			expect(page).to have_content "Oljenkorsi"
			expect(page).to have_content "Karin kellarikomero"
		end
=end		
		it "if no places found, notifies of an error" do
			BeermappingAPI.stub(:places_in).with("kuortane").and_return( [] )
	
			visit places_path
			fill_in('city', :with => 'kuortane')
			click_button "Search"

			expect(page).to have_content "No locations in kuortane"
		end

	end
