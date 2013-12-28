class Rating < ActiveRecord::Base
  attr_accessible :beer_id, :score
  belongs_to :beer
	belongs_to :user

  def to_s
	b = Beer.find_by_id "#{beer_id}"
	return "#{b.name},   #{score}"
  end  
end
