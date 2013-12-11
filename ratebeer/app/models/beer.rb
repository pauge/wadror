class Beer < ActiveRecord::Base
  attr_accessible :brewery_id, :name, :style

  belongs_to :brewery
  has_many :ratings

  def average_rating
     	b = self.ratings.average(:score)
     	return "#{b}" 
  end
  def to_s
	b = Brewery.find_by_id "#{brewery_id}"
 	b = "#{self.name}, #{b.name}" 	
	return b  
end
end
