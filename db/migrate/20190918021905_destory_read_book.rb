class DestoryReadBook < ActiveRecord::Migration[5.2]
  def change
    drop_table :read_books
  end
end
