	require 'spec_helper'
		include OwnTestHelper

describe "User" do
			let!(:user){FactoryGirl.create :user}

	it "when signup accepted is added to the system" do
		visit signup_path

		fill_in('user_username', :with => 'Testi')
		fill_in('user_password', :with => 'Test1')
		fill_in('user_password_confirmation', :with => 'Test1')
		expect{
				click_button('Create User')
		}.to change{User.count}.by(1)				
	end

	describe "who has signed up" do
		it "can sign in with right credentials" do
			sign_in 'Pekka', 'foobar1'	
			expect(page).to have_content 'Welcome back!'
			expect(page).to have_content 'Pekka'
		end

		it "is redirected to sign in if wrong password entered" do
			sign_in 'Pekka', 'wrong'
			expect(current_path).to eq(signin_path)
			expect(page).to have_content 'Incorrect username/password!'
		end
	end
	describe "who has signed in" do
		let!(:brewery){FactoryGirl.create :brewery, :name =>"Koff"}
		let!(:style) {FactoryGirl.create :style}
		before :each do
			sign_in 'Pekka', 'foobar1'
		end

		it "can create a Beer" do
			visit new_beer_path
			fill_in('beer[name]', :with => "Halko")
			select(style.name, :from => 'beer[style_id]')
			select(brewery.name, :from => 'beer[brewery_id]')
			click_button "Create Beer"

			expect(page).to have_content "Listing beers"
			expect(page).to have_content "Halko"

		end
		it "and after rating has a favorite style and brewery" do
			beer = FactoryGirl.create(:beer, :name => "Halko", :style => style, :brewery => brewery)
			rating = FactoryGirl.create(:rating, :beer => beer, :user => user)

			visit user_path(user)
			expect(page).to have_content "Favorite beer style: Lager"
			expect(page).to have_content "Favorite brewery: Koff"

		end
	end
end
