class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :read_books, as: :readable, dependent: :destroy
  has_many :reviews
  has_many :books, through: :reviews

  has_many :reading_histories
  has_many :books, through: :reading_histories

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  # TODO: seedでデータを作ろうとするとエラーが出るので、何かがおかしい
  before_save do
    self.words = self.calc_words
  end

  def calc_words
    count = 0
    self.read_books.each do |book|
      count += book.length
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
      books = read_books.where(["? < created_at and created_at < ?", bom, eom])
      count = 0
      books.each do |b|
        count += b.length
      end
      words_per_month << count
    end
    words_per_month
  end

  # 累計グラフの縦軸
  def calc_cumulative_words
    # グラフには20本のvarを出す
    number_of_books = read_books.count
    count = 0
    words_cumulated = []
    book_count = 0

    if number_of_books >= 0 && number_of_books <= 20
      read_books.each do |book|
        count += book.length
        words_cumulated << count
      end
    elsif number_of_books >= 21 && number_of_books <= 40
      read_books.each do |book|
        book_count += 1
        start_book_count = number_of_books - 20 # 例えば30冊本を読んだとしたら,30 - 20 = 10で、10冊目から30冊目までの20本の縦棒にしたい
        count += book.length
        words_cumulated << count if book_count >= start_book_count
      end
    else
      read_books.each do |book|
        book_count += 1
        start_book_count = 20 # 例えば50冊本を読んだとしたら,50 - 20 = 30で、30冊目から50冊目までの20本の縦棒にしたい
        count += book.length
        words_cumulated << count if book_count >= start_book_count
      end
    end
    words_cumulated
  end

  # 累計グラフの横軸の本の冊数を出す
  def cumulated_book_number
    number_of_books = read_books.count
    book_number_cumulated = []
    book_count = 0

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
end
