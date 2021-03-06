class Beer < ActiveRecord::Base
  include AverageRating
  
  attr_accessible :brewery_id, :name, :style_id

	validates_presence_of :name, :style_id
  belongs_to :brewery
  has_many :ratings, :dependent => :destroy
	has_many :raters, :through => :ratings, :source => :user
	belongs_to :style

 
  def to_s
		b = Brewery.find_by_id "#{brewery_id}"
		b = "#{self.name}, #{b.name}" 	
		return b 
	end

	def self.top_rated(n)
		desc_beers_average_ratings = Beer.all.sort_by{|b| b.average_rating}.reverse!
		return desc_beers_average_ratings.take(n) 
	end
end
