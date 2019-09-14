class Book < ApplicationRecord
  include SearchAmazon

  has_many :reviews
  has_many :users, through: :reviews

  def self.find_books(keyword)
    SearchAmazon.search_books(keyword)
  end

  def self.collect_isbns(keyword)
    SearchAmazon.isbn_list(keyword)
  end
end
