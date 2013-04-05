require 'spec_helper'

describe Stock , :vcr do
  context "#52_week_high" do
    it "should show 52 week high" do
      stock = FactoryGirl.create(:stock)
      stock.year_high.should == "705.07"
    end
  end

  context "#distance_from_52_week_high", :vcr do
    it "should return a float representing the % away from 52 week high" do
      stock = FactoryGirl.create(:stock)
      stock.distance_from_52_week_high.should == 59.92029160225226
    end
  end
  
  context "#indexes_positive?", :vcr do
    it "should return false if the indexes are not positive" do
      stock = FactoryGirl.create(:stock)
      stock.indexes_positive?.should == false
    end

    it "should return true if the indexes are positive" do
      stock = FactoryGirl.create(:stock)
      stock.indexes_positive?.should == true
    end
  end
end
