require 'spec_helper'

describe Brewery do
  describe "when initialized with name and year" do
    subject{Brewery.create name:"Koff", year:1880}

    it{ should be_valid}
    its(:name){ should eq("Koff")}
    its(:year){should eq(1880)}
  end
end
