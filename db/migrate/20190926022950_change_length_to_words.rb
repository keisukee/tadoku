class ChangeLengthToWords < ActiveRecord::Migration[5.2]
  def change
    rename_column :books, :length, :words
  end
end
