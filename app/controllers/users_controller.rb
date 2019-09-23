class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
    gon.cumulated_book_number = @user.cumulated_book_number
    gon.calc_cumulative_words = @user.calc_cumulative_words
    @books = @user.read_books.limit(10)
    @reviews = @user.reading_histories.where(user_id: @user.id).where.not(review: "")
  end

  def update
  end

  def destroy
  end
end
