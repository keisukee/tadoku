class RankingsController < ApplicationController
  def index
    # TODO: 対象のuserを取得するモデルメソッドを作成する
    @this_month_ranking_users = User.first
    @last_month_ranking_users = User.first
    @total_ranking_users = User.first
  end

  def books
  end

  def users
    @users_order_by_words = User.order("words desc").limit(10)
  end

  def authors
  end
end
