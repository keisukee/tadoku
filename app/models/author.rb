class Author < ApplicationRecord
  has_many :read_books, as: :readable
  has_many :books, as: :readable

  validates :name, presence: true
end
