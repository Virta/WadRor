# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

s1 = Style.create name:"Lager", description:"Jotain ihan muuta"
s2 = Style.create name:"IPA", description:"Jotain ihan IPAA"

b1.beers.create name:"Iso 3", style:s1
b1.beers.create name:"Karhu", style:s2
b1.beers.create name:"Tuplahumala", style:s1
b2.beers.create name:"Huvila Pale Ale", style:s2
b2.beers.create name:"X Porter", style:s1
b3.beers.create name:"Hefezeizen", style:s2
b3.beers.create name:"Helles", style:s1

u1 = User.create username:"jaska", password:"Jota1n", password_confirmation:"Jota1n"
u2 = User.create username:"jokunen", password:"Jota1n", password_confirmation:"Jota1n"

c1 = BeerClub.create name:"Olutseura", founded:1986, city:"Helsinki"
c2 = BeerClub.create name:"Panimola", founded:1943, city:"Laihiala"

rating1 = Rating.create score:10, user:u1, beer:b1.beers.first
rating2 = Rating.create score:11, user:u1, beer:b1.beers.first
rating3 = Rating.create score:12, user:u2, beer:b1.beers.first
rating4 = Rating.create score:13, user:u2, beer:b1.beers.first

u1.beer_clubs << c1
u2.beer_clubs << c2

users = 200           # jos koneesi on hidas, riittää esim 100
breweries = 100       # jos koneesi on hidas, riittää esim 50
beers_in_brewery = 40
ratings_per_user = 30

(1..users).each do |i|
  User.create! username:"user_#{i}", password:"Passwd1", password_confirmation:"Passwd1"
end

(1..breweries).each do |i|
  Brewery.create! name:"brewery_#{i}", year:1900, active:true
end

bulk = Style.create! name:"bulk", description:"cheap, not much taste"

Brewery.all.each do |b|
  n = rand(beers_in_brewery)
  (1..n).each do |i|
    beer = Beer.create! name:"beer #{b.id} -- #{i}", style:bulk
    b.beers << beer
  end
end

User.all.each do |u|
  n = rand(ratings_per_user)
  beers = Beer.all.shuffle
  (1..n).each do |i|
    r = Rating.new score:(1+rand(50))
    beers[i].ratings << r
    u.ratings << r
  end
end