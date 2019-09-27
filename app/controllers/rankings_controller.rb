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
  end

  def authors
  end
end
