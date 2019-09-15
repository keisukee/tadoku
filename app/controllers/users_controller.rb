class UsersController < ApplicationController
  def index
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
