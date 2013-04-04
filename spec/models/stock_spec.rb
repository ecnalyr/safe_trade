require 'spec_helper'

describe Stock , :vcr do
  context "#52_week_high" do
    it "should show 52 week high" do
      stock = FactoryGirl.create(:stock)
      stock.year_high.should == "705.07"
    end
  end
end
