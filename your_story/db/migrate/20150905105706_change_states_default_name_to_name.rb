class ChangeStatesDefaultNameToName < ActiveRecord::Migration
  def change
    rename_column :states, :default_name, :name
  end
end
