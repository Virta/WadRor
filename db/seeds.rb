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

b1.beers.create name:"Iso 3", style:"Lager"
b1.beers.create name:"Karhu", style:"Lager"
b1.beers.create name:"Tuplahumala", style:"Lager"
b2.beers.create name:"Huvila Pale Ale", style:"Pale Ale"
b2.beers.create name:"X Porter", style:"Porter"
b3.beers.create name:"Hefezeizen", style:"Weizen"
b3.beers.create name:"Helles", style:"Lager"

u1 = User.create username:"jaska", password:"Jota1n", password_confirmation:"Jota1n"
u2 = User.create username:"jokunen", password:"Jota1n", password_confirmation:"Jota1n"

c1 = BeerClub.create name:"Olutseura", founded:1986, city:"Helsinki"
c2 = BeerClub.create name:"Panimola", founded:1943, city:"Laihiala"

rating1 = Rating.create score:10, user:u1, beer:b1.beers.first
rating2 = Rating.create score:11, user:u1, beer:b1.beers.first
rating3 = Rating.create score:12, user:u1, beer:b1.beers.first
rating4 = Rating.create score:13, user:u1, beer:b1.beers.first
