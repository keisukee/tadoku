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
end
