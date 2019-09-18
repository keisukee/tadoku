class Users::BooksController < ApplicationController
  before_action :set_user

  def index
    @books = @user.read_books
  end

  def new
  end

  def create
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
end
