	require 'spec_helper'
		include OwnTestHelper

describe "User" do
	before :each do
			FactoryGirl.create(:user)
	end

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

end
