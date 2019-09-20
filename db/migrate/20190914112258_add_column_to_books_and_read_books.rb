class AddColumnToBooksAndReadBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :url, :string
    add_column :books, :image_url, :string
    add_column :books, :image_height, :integer
    add_column :books, :image_width, :integer

    add_column :read_books, :url, :string
    add_column :read_books, :image_url, :string
    add_column :read_books, :image_height, :integer
    add_column :read_books, :image_width, :integer
  end
end
