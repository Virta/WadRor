require 'spec_helper'
include OWnTestHelper

describe "Beer" do
  let!(:user) { FactoryGirl.create :user }

  it "is is not saved when no name provided" do
    sign_in(username: 'Teuvo', password: 'SadastaN0llaan')

    visit new_beer_path
    expect(page).to have_content "New beer"

    click_button('Create Beer')

    expect(page).to have_content "New beer"
    expect(page).to have_content "Name is too short (minimum is 3 characters)"
  end

  it "is saved when name is valid" do
    sign_in(username: 'Teuvo', password: 'SadastaN0llaan')

    FactoryGirl.create(:brewery)
    visit new_beer_path
    fill_in('beer[name]', with:'Jekku olut')
    click_button('Create Beer')

    expect(page).to have_content "Jekku olut"
    expect(page).to have_content "Jekku olut has not been rated!"

  end
end