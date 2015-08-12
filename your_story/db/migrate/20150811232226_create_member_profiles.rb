class CreateMemberProfiles < ActiveRecord::Migration
  def change
    create_table :member_profiles do |t|
      t.integer :membership_typ, default: 0
      t.belongs_to :local_chapter, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
