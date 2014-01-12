class Style < ActiveRecord::Base
  attr_accessible :description, :name, :id

	has_many :beers

	def self.top_rated(n)
		h = Hash.new
		
		Style.all.each do |s|
			sum = 0
			s.beers.all.each do |b|
				sum += b.average_rating
			end
			if s.beers.count > 0
				 h[s.name] = sum/s.beers.count
			end
			end
		return Hash[h.sort_by { |k,v| -v}[0..n-1]]
	end
end
