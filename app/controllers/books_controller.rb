class BooksController < ApplicationController
  before_action :book_params, only: [:create, :update]
  before_action :author_params, only: [:create, :update]
  before_action :authenticate_user!, only: [:register]
  before_action :set_book, only: [:show, :register, :edit, :destroy]

  def new
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
  end

  def edit
  end

  def create
    Author.create(name: author_params[:author_name]) unless Author.find_by(name: author_params[:author_name])

    @author = Author.find_by(name: author_params[:author_name])
    if @author.books.create(book_params)
      flash[:success] = '本を登録しました'
    else
      flash[:danger] = '本が登録できませんでした'
    end
    redirect_to books_search_path
  end

  def update
  end

  def search
    @keyword = params[:search]
    # @isbns = Book.collect_isbns(@keyword)
    @books_data = Book.collect_books(@keyword) # 配列の中にハッシュが入っている. ex) [{:url=>"https://www.amazon.co.jp", :image_url=>"https://images-fe.ssl-images-amazon.com/images.jpg", :image_height=>"160160", :image_width=>"107107", :author=>"John Doe", :isbn=>"1975328191", :pages=>"224", :title=>"hogehoge"}]
  end

  def register

  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :isbn, :asin, :url, :image_url, :image_height, :image_width, :pages, :price)
  end

  def author_params
    params.require(:book).permit(:author_name)
  end
end
