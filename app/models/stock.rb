class Stock < ActiveRecord::Base
  validates_presence_of :symbol

  attr_accessible :symbol

  def year_high
    MarketBeat.high_52_week symbol
  end

  def last_trade
    (MarketBeat.last_trade_real_time symbol).to_f
  end

  def distance_from_52_week_high
    last_trade.percent_of(year_high)
  end
end