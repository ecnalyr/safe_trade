require 'spec_helper'

describe Stock , :vcr do
  context "#year_high" do
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

  context "#distance_from_todays_high", :vcr do
    it "should return a float representing the % away from today's high" do
      stock = FactoryGirl.create(:stock)
      stock.distance_from_todays_high.should == 99.38345687727967
    end
  end

  context "#between_thirty_min_away_from_open_and_close?" do
    it "should return true if it is noon EST time" do
      stock = FactoryGirl.create(:stock)
      Timecop.freeze(Time.utc(2013, 4, 5, 17))
      stock.between_thirty_min_away_from_open_and_close?.should == true
    end

    it "should return false if it is 08:31 EST time" do
      Timecop.freeze(Time.utc(2013, 4, 5, 14, 31))
      stock = FactoryGirl.create(:stock)
      stock.between_thirty_min_away_from_open_and_close?.should == false
    end

    it "should return false if it is 07:00 EST time" do
      Timecop.freeze(Time.utc(2013, 4, 5, 13))
      stock = FactoryGirl.create(:stock)
      stock.between_thirty_min_away_from_open_and_close?.should == false
    end
  end
end
