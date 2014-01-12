module AverageRating 
	def average_rating
		b = self.ratings.average(:score)
		if b==nil
			b=0.0
		end
		return b
	end
end
