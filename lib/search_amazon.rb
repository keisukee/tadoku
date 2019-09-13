require 'amazon/ecs'
require 'nokogiri'

module SearchAmazon
  # 初期設定
  Amazon::Ecs.configure do |options|
    options[:AWS_access_key_id] = 'AKIAIJGRPRBNABXLEAVQ'        # 必須
    options[:AWS_secret_key]    = 'eQUS8zuQss19usekzzF63Vf/DnQqsrAk3Zo6tKEA' # 必須
    options[:associate_tag]     = 'affiliate3203-22'            # 必須
    options[:search_index]      = 'Books'                      # 商品種別
    options[:response_group]    = 'Medium'                     # レスポンスに含まれる情報量(ふつう
    options[:country]           = 'jp'                         # 国
  end

  def self.search_books(keyword) # keywordは本の名前, isbn, 著者名など
  # ページング
  res = Amazon::Ecs.item_search(keyword, item_page: 1) # 1pageあたり10個

  # アイテム
    res.items.each do |item|
      puts "--------------------"
      doc = Nokogiri::XML(item.to_s)
      puts "URLは " + doc.xpath("//DetailPageURL").text
      puts ""
      puts "画像URLは " + doc.xpath("//MediumImage//URL").text
      puts ""
      puts "画像URLの高さは " + doc.xpath("//MediumImage//Height").text
      puts ""
      puts "画像URLの長さは " + doc.xpath("//MediumImage//Width").text
      puts ""
      puts "本の著者は " + doc.xpath("//Author").text
      puts ""
      puts "ISBNは " + doc.xpath("//ISBN").text
      puts ""
      puts "ページ数は " + doc.xpath("//NumberOfPages").text
      puts ""
      puts "出版社は " + doc.xpath("//Publisher").text
      puts ""
      puts "タイトルは " + doc.xpath("//Title").text
    end
  end
end