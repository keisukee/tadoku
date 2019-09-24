class Users::BooksController < ApplicationController
  before_action :set_user, only: [:index, :show, :wish, :stacked, :reading, :read]
  before_action :book_params, only: [:create, :update]
  before_action :author_params, only: [:create, :update]
  before_action :reading_history_params, only: [:create, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit]

  def index
    @books = @user.read_books
    @reading_histories = ReadingHistory.where(user_id: @user.id)
  end

  def new
    @book_data = book_params || ""
    @author_data = author_params || ""
    @reading_history_data = reading_history_params || ""
    @book = Book.new
  end

  def create
    Author.create(name: author_params[:author_name]) unless Author.find_by(name: author_params[:author_name])

    @author = Author.find_by(name: author_params[:author_name])
    if @author.books.create(book_params)
      flash[:success] = '本を登録しました'
    else
      flash[:danger] = '本が登録できませんでした'
    end

    @book = Book.find_by(asin: book_params[:asin])

    year = reading_history_params["read_at(1i)"].to_i
    month = reading_history_params["read_at(2i)"].to_i
    day = reading_history_params["read_at(3i)"].to_i
    hour = reading_history_params["read_at(4i)"].to_i
    minute = reading_history_params["read_at(5i)"].to_i
    @read_at = DateTime.new(year, month, day, hour, minute)

    ReadingHistory.create(user_id: current_user.id,
                          book_id: @book.id,
                          read_at: @read_at,
                          review: reading_history_params[:review],
                          level: reading_history_params[:level],
                          words: reading_history_params[:words],
                          genre: reading_history_params[:genre],
                          status: reading_history_params[:status])

    redirect_to user_books_path(current_user)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def wish
    @reading_histories = ReadingHistory.where(user_id: @user.id, status: "wish")
  end

  def stacked
    @reading_histories = ReadingHistory.where(user_id: @user.id, status: "stacked")
  end

  def reading
    @reading_histories = ReadingHistory.where(user_id: @user.id, status: "reading")
  end

  def read
    @reading_histories = ReadingHistory.where(user_id: @user.id, status: "read")
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def book_params
    params.require(:book).permit(:title, :isbn, :asin, :url, :image_url, :image_height, :image_width, :pages, :price)
  end

  def author_params
    params.require(:book).permit(:author_name)
  end

  def reading_history_params
    params.require(:book).permit("read_at(1i)", "read_at(2i)", "read_at(3i)", "read_at(4i)", "read_at(5i)", :review, :words, :level, :genre, :status)
  end

end
