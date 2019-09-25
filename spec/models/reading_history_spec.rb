# == Schema Information
#
# Table name: reading_histories
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  book_id    :bigint
#  read_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  review     :text(65535)
#  level      :decimal(2, 1)
#  genre      :integer
#  words      :integer
#  status     :integer
#

require 'rails_helper'

RSpec.describe ReadingHistory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
