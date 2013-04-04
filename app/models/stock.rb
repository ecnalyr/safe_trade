class Stock < ActiveRecord::Base
  validates_presence_of :symbol

  attr_accessible :symbol

  def year_high
    MarketBeat.high_52_week symbol
  end
end
