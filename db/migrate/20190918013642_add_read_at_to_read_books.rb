class AddReadAtToReadBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :read_books, :read_at, :datetime
  end
end
