class ReadBook < ApplicationRecord
  belongs_to :readable, polymorphic: true

  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :pages, presence: true
  validates :url, presence: true, uniqueness: true
  validates :image_url, presence: true
end
