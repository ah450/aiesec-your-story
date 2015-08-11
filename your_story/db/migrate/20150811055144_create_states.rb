class CreateCities < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :country, null: false
      t.string :default_name, null: false
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.timestamps null: false
    end
    add_index :states, :country
  end
end
