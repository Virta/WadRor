require 'spec_helper'

describe Beer do

  it "is saved with a proper name and style" do
    style = Style.create name:"Lager", description:"N/A"
    beer = Beer.create name:"Joku IPA", style:style

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    style = Style.create name:"Lager", description:"N/A"
    beer = Beer.create style:style

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Joku IPA"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end
