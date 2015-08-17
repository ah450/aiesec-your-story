class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.binary :data
      t.string :mime_type
      t.string :filename
      t.belongs_to :participant, index: true, ull: false

      t.timestamps null: false
    end
  end
end
