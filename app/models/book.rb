# == Schema Information
#
# Table name: books
#
#  id           :bigint           not null, primary key
#  title        :string(255)
#  words       :integer
#  isbn         :string(255)
#  level        :string(255)
#  pages        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  author_id    :bigint
#  url          :text(65535)
#  image_url    :text(65535)
#  image_height :integer
#  image_width  :integer
#  asin         :string(255)
#  price        :string(255)
#

class Book < ApplicationRecord
  include SearchAmazon

  belongs_to :author

  has_many :reading_histories
  has_many :users, through: :reading_histories

  validates :title, presence: true
  validates :isbn, uniqueness: true
  validates :asin, uniqueness: true
  validates :pages, presence: true
  validates :url, presence: true
  validates :image_url, presence: true

  AVERAGE_WORDS_PER_PAGE = 250

  before_save do
    self.words = estimate_book_words
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

  def estimate_book_words
    pages * AVERAGE_WORDS_PER_PAGE
  end
end
