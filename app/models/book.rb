class Book < ApplicationRecord
  belongs_to :readable, polymorphic: true
  has_mamy :reviews
end
