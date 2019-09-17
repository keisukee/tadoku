class Author < ApplicationRecord
  has_many :read_books, as: :readable
  has_many :books

  validates :name, presence: true, uniqueness: true
end
