class Users::MonthliesController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:user_id])
    @year = params[:year].to_i
    @previous_year = @year - 1
    @next_year = @year + 1
    gon.months = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]
    gon.graph_data_array = @user.calc_words_per_month(@year)
  end
end
