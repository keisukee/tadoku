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

FactoryBot.define do
  factory :reading_history do
    user
    book

    factory :reading_history_status_read do
      read
    end

    factory :reading_history_status_reading do
      reading
    end

    factory :reading_history_status_stacked do
      stacked
    end
    factory :reading_history_status_wish do
      wish
    end

    trait :read do
      status { "read" }
      words { 50000 }
      review { "review" }
      genre { "sf" }
      level { 5.5 }
    end

    trait :reading do
      status { "reading" }
    end

    trait :stacked do
      status { "stacked" }
    end

    trait :wish do
      status { "wish" }
    end
  end
end
