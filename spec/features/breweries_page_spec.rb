	require 'spec_helper'
	
	describe "Breweries page" do 
		it 'should not have any before been created' do
			visit breweries_path
			expect(page).to have_content 'Listing breweries'
			expect(page).to have_content 'which there are 0 of'
		end

		it "lists the existing breweries and their total number" do 
			breweries = ["Koff","Karjala", "Schenkerla"]
			breweries. each do |brewery|
				FactoryGirl.create(:brewery, :name => brewery)
			end
			visit breweries_path

			expect(page).to have_content "which there are #{breweries.count} of"

			breweries.each do |brewery|
				expect(page).to have_content brewery
			end
		end

		it "allows user to navigate to page of a Brewery" do
			breweries = ["Koff","Karjala", "Schenkerla"]
			year = 1896
			breweries. each do |brewery|
				FactoryGirl.create(:brewery, :name => brewery, :year => year += 1)
			end
			visit breweries_path
			
			save_and_open_page
			click_link "Koff"

			expect(page).to have_content "Koff"
			expect(page).to have_content "Established year 1987"
		end
	end
