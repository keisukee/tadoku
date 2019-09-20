class Users::ReviewsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @reviews = @user.reading_histories.where(user_id: @user.id).where.not(review: nil)
  end
end
