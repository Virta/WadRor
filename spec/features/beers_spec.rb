require 'spec_helper'
include OWnTestHelper

describe "Beer" do
  it "is is not saved when no name provided" do
    visit new_beer_path
    expect(page).to have_content "New beer"

    click_button('Create Beer')

    expect(page).to have_content "New beer"
    expect(page).to have_content "Name is too short (minimum is 3 characters)"
  end

  it "is saved when name is valid" do
    FactoryGirl.create(:brewery)
    visit new_beer_path
    fill_in('beer[name]', with:'Jekku olut')
    click_button('Create Beer')

    expect(page).to have_content "Jekku olut"
    expect(page).to have_content "Jekku olut has not been rated!"

  end
end