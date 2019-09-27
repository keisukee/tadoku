require 'rails_helper'

RSpec.describe RankingsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #books" do
    it "returns http success" do
      get :books
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #users" do
    it "returns http success" do
      get :users
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #authors" do
    it "returns http success" do
      get :authors
      expect(response).to have_http_status(:success)
    end
  end

end
