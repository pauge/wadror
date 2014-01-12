class Brewery < ActiveRecord::Base
	include AverageRating

  attr_accessible :name, :year, :activity

	validates_presence_of :name, :year
	validates_numericality_of :year, { :greater_than_or_equal_to => 1042,
																		  :only_integer => true }
	validate :year_not_in_future

	scope :active, where(:activity => true)
	scope :retired, where(:activity => [false, nil])
  
	has_many :beers
  has_many :ratings, :through => :beers


	def year_not_in_future
		if self.year > Integer(Time.now.year)
			errors.add(:year, "can't be more than '#{Time.now.year}'")
		end
	end
	def self.top_rated(n)
		desc_brewery_average_ratings = Brewery.all.sort_by{|b| b.average_rating}.reverse!
		return desc_brewery_average_ratings.take(n) 
	end
end
