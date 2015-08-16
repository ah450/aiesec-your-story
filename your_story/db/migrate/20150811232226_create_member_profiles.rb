class CreateMemberProfiles < ActiveRecord::Migration
  def change
    create_table :member_profiles do |t|
      t.integer :membership_typ, default: 0
      t.timestamps null: false
    end
  end
end
