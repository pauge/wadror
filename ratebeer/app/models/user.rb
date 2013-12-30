class User < ActiveRecord::Base
	include AverageRating

	attr_accessible :username, :password, :password_confirmation

	validates_uniqueness_of :username
	validates_length_of :username, :minimum => 3, :maximum => 15
	validates_length_of :password, :minimum => 4
	
	validate :password_contains_only_characters?

	has_secure_password

	has_many :ratings
	has_many :beers, :through => :ratings
	has_many :memberships
	has_many :beer_clubs, :through => :memberships

	def password_contains_only_characters?
		b = true 		#lets assume it does
		if not !!self.password.match(/^[[:alpha:]]+$/) 	#if it DOES HAVE numbers or special characters
			b = false																			#we alter the boolean value. even on hit is enough
		end

		if b == true																		#if the boolean value remains unchanged we return an error
				errors.add(:password, " must have numbers and/or special characters")
		end
	end

end
