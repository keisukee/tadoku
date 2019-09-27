class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:account]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    gon.cumulated_book_number = @user.cumulated_book_number
    gon.calc_cumulative_words = @user.calc_cumulative_words
    @books = @user.read_books.limit(10)
    @reviews = @user.reading_histories.where(user_id: @user.id).where.not(review: "")
  end

  def update
    @user = User.find_by(id: params[:id])
    unless user_params["start_at(1i)"].nil?
      year = user_params["start_at(1i)"].to_i
      month = user_params["start_at(2i)"].to_i
      day = user_params["start_at(3i)"].to_i
      hour = user_params["start_at(4i)"].to_i
      minute = user_params["start_at(5i)"].to_i
    end
    @start_at = DateTime.new(year, month, day, hour, minute) || DateTime.now

    if @user.update(name: user_params[:name],
                    image: user_params[:image],
                    site_name: user_params[:site_name],
                    site_url: user_params[:site_url],
                    introduction: user_params[:introduction],
                    start_at: @start_at)
      flash[:success] = "アカウント情報の更新が完了しました"
    else
      flash[:danger] = "アカウント情報の更新が失敗しました"
    end
    redirect_to account_users_path
  end

  def destroy
  end

  def account
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :site_name, :site_url, :introduction, "start_at(1i)", "start_at(2i)", "start_at(3i)", "start_at(4i)", "start_at(5i)")
  end
end
