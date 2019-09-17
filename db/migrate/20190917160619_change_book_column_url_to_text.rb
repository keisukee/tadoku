class ChangeBookColumnUrlToText < ActiveRecord::Migration[5.2]
  def up
    change_column :books, :url, :text
    change_column :books, :image_url, :text
    change_column :read_books, :url, :text
    change_column :read_books, :image_url, :text
  end

  def down
    change_column :books, :url, :string
    change_column :books, :image_url, :string
    change_column :read_books, :url, :string
    change_column :read_books, :image_url, :string
  end
end
