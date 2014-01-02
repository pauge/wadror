require 'spec_helper'

def create_beer_with_rating(score, user)
	beer = FactoryGirl.create(:beer)
	FactoryGirl.create(:rating, :score => score, :beer => beer, :user => user)
	beer
end

def create_beers_with_rating(*scores, user)
	scores.each do |s|
		create_beer_with_rating s, user
	end
end

describe User do
	it "has the username set correctly" do
		user = User.new :username => "Pekka"

		user.username.should == "Pekka"
	end

	it "is not saved without a proper password" do
		user = User.create :username => "Pekka"

		expect(user.valid?).to be(false)
		expect(User.count).to eq(0)
	end


	describe "favorite beer" do
		let(:user){FactoryGirl.create(:user)}
		it "has a method for determining the favorite_beer" do
			user.should respond_to :favorite_beer
		end

		it "without ratings does not have a favorite beer" do
			expect(user.favorite_beer).to eq (nil)
		end

		it "is the only rated if only one rating" do
			beer = FactoryGirl.create(:beer)
			rating = FactoryGirl.create(:rating, :beer => beer, :user => user)

			expect(user.favorite_beer).to eq(beer)
		end
		it "is the one with the highest rating if several found" do
			create_beer_with_rating 10, user
			best = create_beer_with_rating 25, user
			create_beer_with_rating 7,user

			expect(user.favorite_beer).to eq(best)
		end
	end


	describe "with a proper password"  do
		let(:user){ FactoryGirl.create(:user) }
		
		it "which is not only characters" do
			user.password.match(/^[[:alpha:]]+$/) ==  0 
		end

		it "has a length minimum of 4" do
			if not user.password.nil?
					expect(user.password.length).to be >=4
			end
		end
		
		it "is saved" do
			expect(user.valid?).to be(true)
			expect(User.count).to eq(1)
		end

		it "and with two ratings, has the correct average rating" do
			rating = FactoryGirl.create(:rating)
			rating2 = FactoryGirl.create(:rating2)
		
			user.ratings << rating
			user.ratings << rating2

			expect(user.ratings.count).to eq(2)
			expect(user.average_rating).to eq(15.0)
		end
	end
end

