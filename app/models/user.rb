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

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :reading_histories
  has_many :books, through: :reading_histories

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  # TODO: seedでデータを作ろうとするとエラーが出るので、何かがおかしい
  before_save do
    self.words = calc_words.to_s
  end

  def calc_words
    count = 0
    reading_histories_status_read.each do |reading_history|
      count += reading_history.words unless reading_history.words.nil?
    end
    count
  end

  # 毎月の語数
  def calc_words_per_month(year)
    words_per_month = []
    t = Time.utc(year, 1, 1, 0, 0, 0).in_time_zone # ex) Tue, 01 Jan 2019 00:00:00 UTC +00:00
    (0..11).each do |i|
      bom = t + i.month # bom: beginning of month
      eom = (t + i.month).end_of_month # eof: end of month
      books_per_month = reading_histories.where(["? < read_at and read_at < ?", bom, eom])
      count = 0
      books_per_month.each do |b|
        count += b.words
      end
      words_per_month << count
    end
    words_per_month
  end

  # 累計グラフの縦軸
  def calc_cumulative_words
    # グラフには20本のvarを出す
    number_of_books = reading_histories_status_read.count
    count = 0
    words_cumulated = []
    book_count = 0

    if number_of_books >= 0 && number_of_books <= 20
      reading_histories_status_read.each do |reading_history|
        count += reading_history.words
        words_cumulated << count
      end
    elsif number_of_books >= 21 && number_of_books <= 40
      reading_histories_status_read.each do |reading_history|
        book_count += 1
        start_book_count = number_of_books - 20 # 例えば30冊本を読んだとしたら,30 - 20 = 10で、10冊目から30冊目までの20本の縦棒にしたい
        count += reading_history.words
        words_cumulated << count if book_count >= start_book_count
      end
    else
      reading_histories_status_read.each do |reading_history|
        book_count += 1
        start_book_count = 20 # 例えば50冊本を読んだとしたら,50 - 20 = 30で、30冊目から50冊目までの20本の縦棒にしたい
        count += reading_history.words
        words_cumulated << count if book_count >= start_book_count
      end
    end
    words_cumulated
  end

  # 累計グラフの横軸の本の冊数を出す
  def cumulated_book_number
    number_of_books = reading_histories_status_read.count
    book_number_cumulated = []
    # book_count = 0

    if number_of_books >= 0 && number_of_books <= 20
      (1..number_of_books).each do |i|
        book_number_cumulated << i
      end
    elsif number_of_books >= 21 && number_of_books <= 40
      start = number_of_books - 19 # 30冊本を読んだら11からスタート
      (start..number_of_books).each do |i|
        book_number_cumulated << i # start = 11ならば、11,12,...30までが横軸になる。で、ちゃんと数は20個
      end
    else
      start = number_of_books - 19 # 50冊本を読んだら31からスタート
      (start..number_of_books).each do |i| # start = 51, number_of_books = 70ならば、51, ... 70までの20個
        book_number_cumulated << i # 例えば、100冊本を読んだら、start = 81、81から100まででループが回る
      end
    end
    book_number_cumulated
  end

  def reviews
    reading_histories.where.not(review: "")
  end

  def reading_histories_status_wish
    reading_histories.where(status: "wish")
  end

  def wish_books
    books.joins(:reading_histories).preload(:reading_histories).where(reading_histories: { status: "wish"})
  end

  def reading_histories_status_stacked
    reading_histories.where(status: "stacked")
  end

  def stacked_books
    books.joins(:reading_histories).preload(:reading_histories).where(reading_histories: { status: "stacked"})
  end

  def reading_histories_status_reading
    reading_histories.where(status: "reading")
  end

  def reading_books
    books.joins(:reading_histories).preload(:reading_histories).where(reading_histories: { status: "reading"})
  end

  def reading_histories_status_read
    reading_histories.where(status: "read")
  end

  def read_books
    books.joins(:reading_histories).preload(:reading_histories).where(reading_histories: { status: "read"})
  end

  # TODO: ランキング系はリリース後に実装
  def self.monthly_ranked_user(month)
    # TODO: メソッド修正
    self.joins(:reading_histories).where(reading_histories: {status: "read"}).select('users.*', 'count(reading_histories.id) AS book').group('users.id').order('book desc')
  end

  def entire_period_ranked_user
    # TODO: メソッド修正
    self.joins(:reading_histories).where(reading_histories: {status: "read"}).select('users.*', 'count(reading_histories.id) AS book').group('users.id').order('book desc')
  end
end
