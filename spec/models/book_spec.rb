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

require 'rails_helper'

RSpec.describe Book, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
