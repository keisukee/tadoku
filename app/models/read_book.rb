class ReadBook < ApplicationRecord
  belongs_to :readable, polymorphic: true

  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :pages, presence: true
  validates :url, presence: true, uniqueness: true
  validates :image_url, presence: true

  AVERAGE_WORDS_PER_PAGE = 250

  before_save do
    self.length = estimate_book_length
  end

  def estimate_book_length
    pages * AVERAGE_WORDS_PER_PAGE
  end
end
