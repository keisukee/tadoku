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
    Book.find_books("ruby")
  end

  private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :isbn)
    end

end
