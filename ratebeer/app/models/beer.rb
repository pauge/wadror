class Beer < ActiveRecord::Base
  attr_accessible :brewery_id, :name, :style

  belongs_to :brewery
  has_many :ratings

  def average_rating
     b = self.ratings.average(:score)
     return "#{b}"
     
  end
end
