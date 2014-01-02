require 'spec_helper'

describe Beer do
	it "has to have a name" do
		beer = Beer.create :name => nil

		expect(beer.valid?).to be(false)
		expect(Beer.count).to eq(0)
	end

	it "has to have a style" do
		beer = Beer.create :name => "Kolmonen", :style => nil

		expect(beer.valid?).to be(false)
		expect(Beer.count).to eq(0)
	end
end

