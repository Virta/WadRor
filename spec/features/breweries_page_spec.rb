require 'spec_helper'

describe "Breweries page" do
  it "should not have any before creation" do
    visit breweries_path
    expect(page).to have_content 'Listing breweries'
    expect(page).to have_content 'Number of breweries: 0'
  end

  describe "when breweries exist" do
    before :each do
      @breweries = ["Koff", "Karjala", "Schenkerla"]
      year = 1880
      @breweries.each do |name|
        FactoryGirl.create(:brewery, name:name)
      end

      visit breweries_path
    end

    it "lists existing and total number" do
      expect(page).to have_content "Number of breweries: #{@breweries.count}"

      @breweries.each do |b|
        expect(page).to have_content b
      end
    end

    it "allows navigation to brewery page" do
      click_link "Koff"

      expect(page).to have_content "Koff"
      expect(page).to have_content "Established in: 1880"
    end
  end

end