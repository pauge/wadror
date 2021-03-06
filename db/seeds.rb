# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Brewery.create :name => "Koff", :year => 1897, :activity =>true 
b2 = Brewery.create :name => "Malmgard", :year => 2001, :activity => true
b3 = Brewery.create :name => "Weihenstephaner", :year => 1042, :activity => true
b4 = Brewery.create :name => "Oldies Goldie", :year => 1043, :activity => false

s1 = Style.create :name => "Lager"
s2 = Style.create :name => "Weizen"
s3 = Style.create :name => "Pale Ale"
s4 = Style.create :name => "Weizenbock"
s5 = Style.create :name => "Porter"

u = User.create :username => "admin", :password => "1234", :password_confirmation => "1234", :admin => true


b1.beers.create :name => "Iso 3", :style_id => s1.id
b1.beers.create :name => "Karhu", :style_id  => s1.id
b1.beers.create :name => "Tuplahumala", :style_id => s1.id
b2.beers.create :name => "Huvila Pale Ale", :style_id => s3.id
b2.beers.create :name => "X Porter", :style_id => s5.id
b3.beers.create :name => "Hefeweizen", :style_id => s2.id
b3.beers.create :name => "Helles", :style_id => s1.id
b1.beers.create :name => "Aventinus", :style_id => s4.id


