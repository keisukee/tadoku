class ReadBook < ApplicationRecord
  belongs_to :readable, polymorphic: true
end
