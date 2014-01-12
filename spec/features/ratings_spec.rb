require 'spec_helper'
	include OwnTestHelper

describe "Rating" do
	let!(:brewery){FactoryGirl.create :brewery, :name => "Koff"}
	let!(:beer1){FactoryGirl.create :beer, :name => "Iso 3", :brewery => brewery}
	let!(:beer2){FactoryGirl.create :beer, :name => "Karhu", :brewery => brewery}
	let!(:user){FactoryGirl.create :user}

	before :each do
		sign_in 'Pekka', 'foobar1'
	end

	it "when given, is registered to the beer and user who is signed in" do
		visit new_rating_path
		select(beer1.to_s, :from => 'rating[beer_id]')
		fill_in('rating[score]', :with => '15')
		
		expect{
				click_button "Create Rating"
		}.to change{Rating.count}.from(0).to(1)
	
		expect(user.ratings.count).to eq(1)
		expect(beer1.ratings.count).to eq(1)
		expect(beer1.average_rating).to eq(15.0)
	end

	it "is shown in Ratings -page" do
		create_two_ratings

		visit ratings_path
		expect(page).to have_content "Rating statistics"
		expect(page).to have_content "Iso 3, 15"
		expect(page).to have_content "Karhu, 17"
	end

	it "are shown on the users page" do
		create_two_ratings

		visit user_path(user)
		expect(page).to have_content "Pekka"
		expect(page).to have_content "Iso 3, 15 Delete"
		expect(page).to have_content "Karhu, 17"
	end
	it "disappears from users page after deletion" do
		visit new_rating_path
		select(beer1.to_s, :from => 'rating[beer_id]')
		fill_in('rating[score]', :with => '15')
		click_button "Create Rating"
		
		visit user_path(user)

		expect(page).to have_content("Iso 3")
		
		first(:link,  "Delete").click
		
		expect(Rating.count).to eq(0)
		end
end
