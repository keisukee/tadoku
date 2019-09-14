require 'amazon/ecs'
require 'nokogiri'

module SearchAmazon
  # 初期設定
  Amazon::Ecs.configure do |options|
    options[:AWS_access_key_id] = ENV['AWS_ACCESS_KEY_ID']        # 必須
    options[:AWS_secret_key]    = ENV['AWS_SECRET_KEY'] # 必須
    options[:associate_tag]     = ENV['ASSOCIATE_TAG']            # 必須
    options[:search_index]      = 'Books'                      # 商品種別
    options[:response_group]    = 'Medium'                     # レスポンスに含まれる情報量(ふつう
    options[:country]           = 'jp'                         # 国
  end

  class << self
    def search_books(keyword) # keywordは本の名前, isbn, 著者名など
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

    def isbn_list(keyword)
      res = Amazon::Ecs.item_search(keyword, item_page: 1) # 1pageあたり10個
      isbns = []
      res.items.each do |item|
        doc = Nokogiri::XML(item.to_s)
        isbns << doc.xpath("//ISBN").text
      end
      isbns
    end

    def search_book_url(isbn)
      res = Amazon::Ecs.item_search(isbn, item_page: 1) # 1pageあたり10個
      item = res.items.first

      doc = Nokogiri::XML(item.to_s)
      doc.xpath("//DetailPageURL").text
    end

    def search_book_image(isbn)
      res = Amazon::Ecs.item_search(isbn, item_page: 1) # 1pageあたり10個
      item = res.items.first

      doc = Nokogiri::XML(item.to_s)
      doc.xpath("//MediumImage//URL").text
    end

    def search_book_image_height(isbn)
      res = Amazon::Ecs.item_search(isbn, item_page: 1) # 1pageあたり10個
      item = res.items.first

      doc = Nokogiri::XML(item.to_s)
      doc.xpath("//MediumImage//Height").text
    end

    def search_book_image_width(isbn)
      res = Amazon::Ecs.item_search(isbn, item_page: 1) # 1pageあたり10個
      item = res.items.first

      doc = Nokogiri::XML(item.to_s)
      doc.xpath("//MediumImage//Width").text
    end

    def search_book_author(isbn)
      res = Amazon::Ecs.item_search(isbn, item_page: 1) # 1pageあたり10個
      item = res.items.first

      doc = Nokogiri::XML(item.to_s)
      doc.xpath("//Author").text
    end

    def search_book_pages(isbn)
      res = Amazon::Ecs.item_search(isbn, item_page: 1) # 1pageあたり10個
      item = res.items.first

      doc = Nokogiri::XML(item.to_s)
      doc.xpath("//NumberOfPages").text
    end

    def search_book_title(isbn)
      res = Amazon::Ecs.item_search(isbn, item_page: 1) # 1pageあたり10個
      item = res.items.first

      doc = Nokogiri::XML(item.to_s)
      doc.xpath("//Title").text
    end
  end
end