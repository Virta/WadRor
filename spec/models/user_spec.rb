require 'spec_helper'

BeerClub
BeerClubsController
Membership
MembershipsController

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  describe "is not saved without a proper password" do
    let(:user){ user = User.new username:"Pekka" }

    it "if password nonexsistent" do
      user.save
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "if password contains only letters" do
      user.password="kirjaimia"
      user.password_confirmation="kirjaimia"
      user.save

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end
  end

  #it "is not saved without a proper passwd" do
  #  user = User.create username:"Joku", password:"jotain", password_confirmation:"jotain"
  #
  #  expect(user).not_to be_valid
  #  expect(User.count).to eq(0)
  #end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favourite beer" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for their favourite_beer" do
      user.should respond_to :favourite_beer
    end

    it "without ratings doesn't have a favourite beer" do
      expect(user.favourite_beer).to eq(nil)
    end

    it "has correct beer when only one rating for user exists" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favourite_beer).to eq(beer)
    end

    it "is the one with highest rating when several ratings exist" do
      best = create_beer_with_rating(25, user)
      create_beer_with_ratings(1, 2, 3, 4, 5, 19, user)

      expect(user.favourite_beer).to eq(best)
    end
  end

  describe "favourite style" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for favourite_style"  do
      user.should respond_to :favourite_style
    end

    it "is nonexistent with zero ratings" do
      expect(user.favourite_style).to eq(nil)
    end

    it "returns correct style when user has only one rating" do
      style = FactoryGirl.create(:style)
      beer = FactoryGirl.create(:beer, style:style)
      FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favourite_style).to eq(style)
    end

    it "returns correct style when user has multiple ratings" do
      style1 = Style.create name:"Lager", description:'N/A'
      style2 = Style.create name:"IPA", description:'N/A'

      create_many_beers_with_style(1, 2, 3, style1, user)
      create_many_beers_with_style(13, 14, 15, style2, user)

      expect(user.favourite_style).to eq(style2)
    end
  end

  describe "favourite brewery" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for determining favourite brewery" do
      user.should respond_to :favourite_brewery
    end

    it "returns no brewery when no ratings" do
      expect(user.favourite_brewery).to eq(nil)
    end

    it "returns correct brewery when one rating" do
      beer = create_beer_with_rating(10, user)

      expect(user.favourite_brewery).to eq(beer.brewery)
    end

    it "returns correct brewery when multiple ratings" do
      create_with_brewery(1, 2, 3, 4, "Panimo 1", user)
      create_with_brewery(5, 6, 7, 8, "Panimo 2", user)

      expect(user.favourite_brewery.name).to eq("Panimo 2")
    end
  end

  def create_beer_with_rating(score, user)
    style = FactoryGirl.create(:style)
    brewery = FactoryGirl.create(:brewery)
    beer = FactoryGirl.create(:beer, style:style, brewery:brewery)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beer_with_ratings(*scores, user)
    scores.each do|score|
      create_beer_with_rating(score, user)
    end
  end

  def create_many_beers_with_style(*scores, style, user)
    beer = FactoryGirl.create(:beer, style:style)
    scores.each do |score|
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    end
  end

  def create_custom_beer_with_rating(score, brewery_name, user)
    brewery = FactoryGirl.create(:brewery, name:brewery_name)
    style = FactoryGirl.create(:style)
    beer = FactoryGirl.create(:beer, brewery:brewery, style:style)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  end

  def create_with_brewery(*scores, brewery_name, user)
    scores.each do |s|
      create_custom_beer_with_rating(s, brewery_name, user)
    end
  end

end
