require 'spec_helper'
include OWnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username: 'Teuvo', password: 'SadastaN0llaan')
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)

    visit ratings_path
    expect(page).to have_content "Total ratings: 1"

  end

  it "displays all ratings of the user and deletes accordingly" do
    visit new_rating_path
    fill_in('rating[score]', with:'15')
    click_button('Create Rating')

    visit user_path(user)
    expect(page).to have_content "Has made 1 rating."

    click_link('delete')

    visit user_path(user)
    expect(page).to have_content "Has made 0 ratings."
  end
end