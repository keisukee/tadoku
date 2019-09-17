class Book < ApplicationRecord
  include SearchAmazon

  has_many :reviews
  has_many :users, through: :reviews
  belongs_to :author

  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :pages, presence: true
  validates :url, presence: true, uniqueness: true
  validates :image_url, presence: true

  AVERAGE_WORDS_PER_PAGE = 250

  before_save do
    self.length = estimate_book_length
  end

  def self.find_books(keyword)
    SearchAmazon.search_books(keyword)
  end

  def self.collect_isbns(keyword)
    SearchAmazon.isbn_list(keyword)
  end

  def self.collect_books(keyword)
    SearchAmazon.collect_books(keyword)
  end

  def estimate_book_length
    pages * AVERAGE_WORDS_PER_PAGE
  end
end
