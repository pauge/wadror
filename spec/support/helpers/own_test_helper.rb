module OwnTestHelper
	def sign_in(username, password)
		visit signin_path
		fill_in('username', :with => username)
		fill_in('password', :with => password)

		click_button('Log in')
	end

	def create_two_ratings
		visit new_rating_path
		select(beer1.to_s, :from => 'rating[beer_id]')
		fill_in('rating[score]', :with => '15')
		click_button "Create Rating"

		visit new_rating_path
		select(beer2.to_s, :from => 'rating[beer_id]')
		fill_in('rating[score]', :with => '17')
		click_button "Create Rating"		
	end
end
