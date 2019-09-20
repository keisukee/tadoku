class ChangeLevelColumnInReadingHistories < ActiveRecord::Migration[5.2]
  def up
    change_column :reading_histories, :level, :decimal, precision: 2, scale: 1
  end

  def down
    change_column :reading_histories, :level, :integer
  end
end
