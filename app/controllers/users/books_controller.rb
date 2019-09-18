class Users::BooksController < ApplicationController
  before_action :set_user
  before_action :book_params, only: [:create, :update]
  before_action :author_params, only: [:create, :update]
  before_action :reading_history_params, only: [:create, :update]

  def index
    @books = @user.books
  end

  def new
    @book = Book.new
    @keyword = params[:search]
    # @isbns = Book.collect_isbns(@keyword)
    @books_data = Book.collect_books(@keyword) # 配列の中にハッシュが入っている. ex) [{:url=>"https://www.amazon.co.jp", :image_url=>"https://images-fe.ssl-images-amazon.com/images.jpg", :image_height=>"160160", :image_width=>"107107", :author=>"John Doe", :isbn=>"1975328191", :pages=>"224", :title=>"hogehoge"}]
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
