class HomeController < ApplicationController
  def index
    @users = User.all
    @latest_apple_quote = MarketBeat.last_trade_real_time :AAPL
    @year_high = MarketBeat.high_52_week :AAPL
  end
end
