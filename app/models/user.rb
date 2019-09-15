class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :read_books, as: :readable, dependent: :destroy
  has_many :reviews
  has_many :books, through: :reviews

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  before_save do
    self.words = self.count_words
  end

  def count_words
    count = 0
    self.read_books.each do |book|
      count += book.length
    end
    count
  end
end
