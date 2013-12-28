class Beer < ActiveRecord::Base
  include AverageRating
  
  attr_accessible :brewery_id, :name, :style

  belongs_to :brewery
  has_many :ratings, :dependent => :destroy
	has_many :raters, :through => :ratings, :source => :user

 
  def to_s
	b = Brewery.find_by_id "#{brewery_id}"
 	b = "#{self.name}, #{b.name}" 	
	return b  
end
end
