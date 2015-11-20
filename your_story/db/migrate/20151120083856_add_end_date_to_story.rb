class AddEndDateToStory < ActiveRecord::Migration
  def change
    add_column :stories, :duration, :integer
  end
end
