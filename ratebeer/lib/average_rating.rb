module AverageRating 
	def average_rating
		b = self.ratings.average(:score)
		return b
	end
end
