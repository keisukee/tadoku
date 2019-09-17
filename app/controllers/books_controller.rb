class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Bool.find(params[:id])
  end

  def destroy
  end

  def edit
  end

  def new
  end

  def create
  end

  def update
  end

  def search
    @keyword = params[:search]
    # @isbns = Book.collect_isbns(@keyword)
    @books_data = Book.collect_books(@keyword) # 配列の中にハッシュが入っている. ex) [{:url=>"https://www.amazon.co.jp", :image_url=>"https://images-fe.ssl-images-amazon.com/images.jpg", :image_height=>"160160", :image_width=>"107107", :author=>"John Doe", :isbn=>"1975328191", :pages=>"224", :title=>"hogehoge"}]
  end

  private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :isbn)
    end

end
