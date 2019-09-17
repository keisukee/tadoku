class UsersController < ApplicationController
  def index
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    gon.cumulated_book_number = @user.cumulated_book_number
    gon.calc_cumulative_words = @user.calc_cumulative_words
  end

  def update
  end

  def destroy
  end
end
