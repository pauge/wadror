class Rating < ActiveRecord::Base
  attr_accessible :beer_id, :score
 
 	validates_numericality_of :score, { :greater_than_or_equal_to => 1,
																			:less_than_or_equal_to => 50,
																			:only_integer => true }
 
 	belongs_to :beer
	belongs_to :user

  def to_s
	b = Beer.find_by_id "#{beer_id}"
	return "#{b.name},   #{score}"
  end  
end
