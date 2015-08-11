class CreateCityNames < ActiveRecord::Migration
  def change
    create_table :state_names do |t|
      t.string :name
      t.belongs_to :state, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_index :state_names, :name
  end
end
