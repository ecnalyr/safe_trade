class Stock < ActiveRecord::Base
  validates_presence_of :symbol

  attr_accessible :symbol

  def year_high
    MarketBeat.high_52_week symbol
  end

  def todays_high
    MarketBeat.days_high symbol
  end

  def last_trade
    (MarketBeat.last_trade_real_time symbol).to_f
  end

  def distance_from_52_week_high
    last_trade.percent_of(year_high)
  end

  def distance_from_todays_high
    last_trade.percent_of(todays_high)
  end

  def indexes_positive?
    #Checks S&P 500 and NASDAQ, does not check DJI because I was having difficulty with the api
    gspc = (MarketBeat.days_value_change_real_time :"%5EGSPC")[1].gsub("%", "").to_f
    ixic = (MarketBeat.days_value_change_real_time :"%5EIXIC")[1].gsub("%", "").to_f
    gspc > 0 && ixic > 0
  end

  def between_thirty_min_away_from_open_and_close?
    now = Time.now.in_time_zone("EST")
    start = DateTime.now.in_time_zone("EST").beginning_of_day + 10.hours #10:00 am est
    stop = DateTime.now.in_time_zone("EST").beginning_of_day + 15.hours + 30.minutes #3:30 pm est
    (start..stop).cover?(now)
  end


end