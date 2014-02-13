require 'spec_helper'
include OWnTestHelper

describe "User" do

  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:style1) { FactoryGirl.create :style, name:"Lager", description:'N/A' }
  let!(:style2) { FactoryGirl.create :style, name:"IPA", description:'N/A' }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery, style:style1 }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery, style:style2 }
  let!(:user) { FactoryGirl.create :user }

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: 'Teuvo', password: 'SadastaN0llaan')

      expect(page).to have_content "Welcome back!"
      expect(page).to have_content "Teuvo"
    end

    it "is redirected back to signin if wrong password" do
      sign_in(username: 'Teuvo', password: 'Jotain')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Wrong username or password!'
    end

    it "shows favourite beer and brewery when ratings" do
      sign_in(username: 'Teuvo', password: 'SadastaN0llaan')

      visit user_path(user)
      expect(page).not_to have_content "Favourite style"
      expect(page).not_to have_content "Favourite brewery"

      FactoryGirl.create(:rating, user:user, beer:beer1, score:10)

      visit user_path(user)
      expect(page).to have_content "Favourite style: Lager"
      expect(page).to have_content "Favourite brewery: Koff"

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