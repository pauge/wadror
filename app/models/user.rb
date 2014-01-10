class User < ActiveRecord::Base
	include AverageRating

	attr_accessible :username, :password, :password_confirmation, :admin

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
		if not self.password.nil?
			b = true 		#lets assume it does
			if not !!self.password.match(/^[[:alpha:]]+$/) 	#if it DOES HAVE numbers or special characters
				b = false																			#we alter the boolean value. even on hit is enough
			end

			if b == true																		#if the boolean value remains unchanged we return an error
				errors.add(:password, " must have numbers and/or special characters")
			end
		end
	end

	def favorite_beer
		return nil if ratings.empty?
		ratings.sort_by{ |r| r.score}.last.beer
	end

	def get_styles
		styles = Style.all
		return styles.map{|s| s.name }.uniq 
	end

	def style_average?
		h = Hash.new
		s = get_styles
		sum = 0
		i = 0
		s.each do |sty|
			ratings.each do |r|
				if r.beer.style.name.eql?(sty) #get the sum of scores for a beer type
					sum = sum + r.score
					i +=1
					end
				end
				if i >0
					h[sty] = sum/i #add the style and average into a hash
					sum = 0
					i = 0
				end
			end
			return h #return hash containing all styles and their average points
	end
	def top_rated_style
		return nil if ratings.empty?

		s = style_average?.max_by{|k,v|v}
		return s[0]
	end

	def brewery_average
		h = Hash.new
		sum = 0
		i = 0
		Brewery.all.each do |b|
			ratings.each do |r|
				if r.beer.brewery.name.eql?(b.name)
					sum = sum + r.score
					i += 1
				end
			end
				if i > 0
					h[b.name] = sum/i
					sum = 0
					i = 0
				end	
		end	
		return h
	end

	def top_rated_brewery
		return nil if ratings.empty?

		s = brewery_average.max_by{|k,v| v}
		return s[0]
	end
end

