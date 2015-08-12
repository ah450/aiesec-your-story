class CreateTalentProfiles < ActiveRecord::Migration
  def change
    create_table :talent_profiles do |t|
      t.boolean :outgoing, null: false

      t.timestamps null: false
    end
  end
end
