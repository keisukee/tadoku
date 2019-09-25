# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Author < ApplicationRecord
  has_many :books

  validates :name, presence: true, uniqueness: true
end
