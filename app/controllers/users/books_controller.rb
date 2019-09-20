class Users::BooksController < ApplicationController
  before_action :set_user, only: [:index, :show]
  before_action :book_params, only: [:new, :create, :update]
  before_action :author_params, only: [:new, :create, :update]
  before_action :reading_history_params, only: [:new, :create, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit]

  def index
    @books = @user.books
  end

  def new
    @book_data = book_params
    @author_data = author_params
    @reading_history_data = reading_history_params
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

    ReadingHistory.create(user_id: @user.id, book_id: @book.id, read_at: @read_at)

    redirect_to user_books_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def register
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
    params.require(:book).permit("read_at(1i)", "read_at(2i)", "read_at(3i)", "read_at(4i)", "read_at(5i)")
  end

end
