require 'spec_helper'

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
    let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"}

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
end
