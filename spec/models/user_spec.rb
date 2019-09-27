# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  words                  :string(255)
#  title                  :string(255)
#  name                   :string(255)
#  image                  :string(255)
#  start_at               :datetime
#  introduction           :text(65535)
#  site_name              :string(255)
#  site_url               :string(255)
#

require 'rails_helper'

RSpec.describe User, type: :model do

  describe "userが読んだ本を登録した場合" do
    let!(:user1) { create(:user) }

    let(:book1) { create(:book) }
    let(:reading_history1) { create(:reading_history_status_read, user: user1, book: book1) }

    let(:book2) { create(:book) }
    let(:reading_history2) { create(:reading_history_status_read, user: user1, book: book2) }

    let(:book3) { create(:book) }
    let(:reading_history3) { create(:reading_history_status_read, user: user1, book: book3) }

    it "読んだ本の語数が正確に反映されること" do
      total = reading_history1.words + reading_history2.words + reading_history3.words
      expect(user1.words).to eq(total.to_s)
    end
  end

  describe "先月に読んだ本を登録したとき" do
    let!(:user1) { create(:user) }
    let!(:book1) { create(:book) }
    let!(:reading_history1) { create(:reading_history_status_read_one_month_ago, user: user1, book: book1) }
    let!(:book2) { create(:book) }
    let!(:reading_history2) { create(:reading_history_status_read_one_month_ago, user: user1, book: book2) }
    let!(:book3) { create(:book) }
    let!(:reading_history3) { create(:reading_history_status_read_one_month_ago, user: user1, book: book3) }

    it "先月読んだ語数と冊数が正しく反映されること" do
      start_of_last_month = (DateTime.now - 1.month).beginning_of_month
      end_of_last_month = (DateTime.now - 1.month).end_of_month
      last_month_books_count = user1.reading_histories_status_read.where(["? < read_at and read_at < ?", start_of_last_month, end_of_last_month]).count
      total = reading_history1.words + reading_history2.words + reading_history3.words
      expect(user1.words.to_i).to eq total
      expect(user1.reading_histories_status_read.count).to eq last_month_books_count
    end
  end

  describe "読んだ本の累計データ" do
    let!(:user1) { create(:user) }

    let!(:book1) { create(:book) }
    let!(:reading_history1) { create(:reading_history_status_read_one_month_ago, user: user1, book: book1) }

    let!(:book2) { create(:book) }
    let!(:reading_history2) { create(:reading_history_status_read_two_month_ago, user: user1, book: book2) }

    let!(:book3) { create(:book) }
    let!(:reading_history3) { create(:reading_history_status_read_three_month_ago, user: user1, book: book3) }

    let!(:book4) { create(:book) }
    let!(:reading_history4) { create(:reading_history_status_read_four_month_ago, user: user1, book: book4) }

    it "#calc_cumulative_words が正しく動作すること" do
      words_cumulated = user1.calc_cumulative_words
      expected_words_cumulated = [50000, 100000, 150000, 200000]
      expect(words_cumulated).to eq expected_words_cumulated
    end

    it "#cumulated_book_number が正しく動作すること" do
      book_number_cumulated = user1.cumulated_book_number
      expected_book_number_cumulated = [1, 2, 3, 4]
      expect(book_number_cumulated).to eq expected_book_number_cumulated
    end

  end
end
