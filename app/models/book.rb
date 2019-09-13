class Book < ApplicationRecord
  include SearchAmazon

  has_many :reviews
  has_many :users, through: :reviews

  def self.find_books(keyword)
    SearchAmazon.search_books(keyword)
  end
end
