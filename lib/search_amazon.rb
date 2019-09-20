require 'amazon/ecs'
require 'nokogiri'
require 'dotenv'

module SearchAmazon
  # 初期設定
  Dotenv.load!
  Amazon::Ecs.configure do |options|
    options[:AWS_access_key_id] = ENV['AWS_ACCESS_KEY_ID'] # 必須
    options[:AWS_secret_key]    = ENV['AWS_SECRET_KEY'] # 必須
    options[:associate_tag]     = ENV['ASSOCIATE_TAG'] # 必須
    options[:search_index]      = 'Books'                      # 商品種別
    options[:response_group]    = 'Medium'                     # レスポンスに含まれる情報量(ふつう
    options[:country]           = 'jp'                         # 国
  end

  class << self
    # keywordは本の名前, isbn, 著者名など
    def search_books(keyword)
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
        puts "画像URLの高さは " + doc.xpath("//Item/MediumImage//Height").text
        puts ""
        puts "画像URLの長さは " + doc.xpath("//Item/MediumImage//Width").text
        puts ""
        puts "本の著者は " + doc.xpath("//Author").text
        puts ""
        puts "ISBNは " + doc.xpath("//ISBN").text
        puts ""
        puts "ASINは " + doc.xpath("//ASIN").text
        puts ""
        puts "ページ数は " + doc.xpath("//NumberOfPages").text
        puts ""
        puts "値段は " + doc.xpath("//ListPrice//FormattedPrice").text
        puts ""
        puts "出版社は " + doc.xpath("//Publisher").text
        puts ""
        puts "タイトルは " + doc.xpath("//Title").text
      end
    end

    # hashを返す
    def collect_books(keyword)
      books = []
      res = Amazon::Ecs.item_search(keyword, item_page: 1) # 1pageあたり10個

      res.items.each do |item|
        books_info = {}
        doc = Nokogiri::XML(item.to_s)
        books_info[:url] = doc.xpath("//DetailPageURL").text
        books_info[:image_url] = doc.xpath("//MediumImage//URL").text
        books_info[:image_height] = doc.xpath("//Item/MediumImage//Height").text
        books_info[:image_width] = doc.xpath("//Item/MediumImage//Width").text
        books_info[:author] = doc.xpath("//Author").text
        books_info[:isbn] = doc.xpath("//ISBN").text
        books_info[:asin] = doc.xpath("//ASIN").text
        books_info[:pages] = doc.xpath("//NumberOfPages").text
        books_info[:title] = doc.xpath("//Title").text
        books_info[:price] = doc.xpath("//ListPrice//FormattedPrice").text

        books << books_info
      end
      books
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
      doc.xpath("//Item/MediumImage//Height").text
    end

    def search_book_image_width(isbn)
      res = Amazon::Ecs.item_search(isbn, item_page: 1) # 1pageあたり10個
      item = res.items.first

      doc = Nokogiri::XML(item.to_s)
      doc.xpath("//Item/MediumImage//Width").text
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