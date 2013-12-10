class Beer < ActiveRecord::Base
  attr_accessible :brewery_id, :name, :style

  belongs_to :brewery
  has_many :ratings

  def average_rating
  	b = 0
     self.ratings.each do |rating|
 	b = b + rating.score
     end
        b = b / self.ratings.count
     return "#{b}" 
     
  end
end
