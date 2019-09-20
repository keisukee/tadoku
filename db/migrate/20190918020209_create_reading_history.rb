class CreateReadingHistory < ActiveRecord::Migration[5.2]
  def change
    create_table :reading_histories do |t|
      t.belongs_to :user
      t.belongs_to :book
      t.datetime :read_at
      t.timestamps
    end
  end
end
