module SearchHelper
  include SearchAmazon

  def book_url(isbn)
    SearchAmazon.search_book_url(isbn)
  end

  def book_image(isbn)
    SearchAmazon.search_book_image(isbn)
  end

  def book_image_height(isbn)
    SearchAmazon.search_book_image_height(isbn)
  end

  def book_image_width(isbn)
    SearchAmazon.search_book_image_width(isbn)
  end

  def book_author(isbn)
    SearchAmazon.search_book_author(isbn)
  end

  def book_pages(isbn)
    SearchAmazon.search_book_pages(isbn)
  end

  def book_title(isbn)
    SearchAmazon.search_book_title(isbn)
  end

end
