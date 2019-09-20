class AddColumnToReadingHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :reading_histories, :review, :text
    add_column :reading_histories, :level, :integer
    add_column :reading_histories, :genre, :string
    add_column :reading_histories, :words, :integer
  end
end
