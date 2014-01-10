class Style < ActiveRecord::Base
  attr_accessible :description, :name, :id

	has_many :beers
end
