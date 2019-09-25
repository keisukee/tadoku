require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do

  describe "GET #show" do
    let!(:author) { create(:author) }

    it "returns http success" do
      post :show, params: { id: author.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
