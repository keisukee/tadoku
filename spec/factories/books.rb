# == Schema Information
#
# Table name: books
#
#  id           :bigint           not null, primary key
#  title        :string(255)
#  length       :integer
#  isbn         :string(255)
#  level        :string(255)
#  pages        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  author_id    :bigint
#  url          :text(65535)
#  image_url    :text(65535)
#  image_height :integer
#  image_width  :integer
#  asin         :string(255)
#  price        :string(255)
#

FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "title#{n}" }
    sequence(:isbn) { |n| "abc#{n}" }
    sequence(:asin) { |n| "abc#{n}" }
    sequence(:url) { |n| "https://url/#{n}"}
    sequence(:image_url) { |n| "https://image_url/#{n}"}
    pages { 350 }
    image_height { 300 }
    image_width { 200 }
    price { "1500" }
    length { 50000 }
    author
  end
end
