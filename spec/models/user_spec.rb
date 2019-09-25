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

    before do
      puts reading_history1.inspect
      puts "-----"
      puts reading_history2.inspect
      puts "-----"
      puts reading_history3.inspect
      puts "-----"
      puts user1.read_books
      user1.save
    end
    it "読んだ本の語数が正確に反映されること" do
      total = reading_history1.words + reading_history2.words + reading_history3.words
      expect(user1.words).to eq(total)
    end
  end
end
