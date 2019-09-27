require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  describe "GET #show" do
    let!(:book) { create(:book) }

    it "returns http success" do
      post :show, params: { id: book.id }
      expect(response).to have_http_status(:success)
    end
  end
end
