class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.text :highlight
      t.belongs_to :participant, index: true, foreign_key: true
      t.belongs_to :state, index: true, foreign_key: true
      t.date :date
      t.timestamps null: false
    end
  end
end
