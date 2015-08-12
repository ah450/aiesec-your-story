class CreateLocalChapters < ActiveRecord::Migration
  def change
    create_table :local_chapters do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
