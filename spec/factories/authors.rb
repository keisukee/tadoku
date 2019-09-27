# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :author do
    sequence(:name) { |n| "author#{n}" }
  end
end