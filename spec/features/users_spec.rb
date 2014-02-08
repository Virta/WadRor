require 'spec_helper'
include OWnTestHelper

describe "User" do
  before :each do
    FactoryGirl.create(:user)
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      visit signin_path

      sign_in(username: 'Teuvo', password: 'SadastaN0llaan')

      expect(page).to have_content "Welcome back!"
      expect(page).to have_content "Teuvo"
    end

    it "is redirected back to signin if wrong password" do
      visit signin_path

      sign_in(username: 'Teuvo', password: 'Jotain')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Wrong username or password!'
    end
  end

  it "is added to the system when siging up with valid credentials" do
    visit signup_path

    fill_in('user_username', with: 'Jaska')
    fill_in('user_password', with: 'Jokunen1')
    fill_in('user_password_confirmation', with: 'Jokunen1')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
end