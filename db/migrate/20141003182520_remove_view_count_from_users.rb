class RemoveViewCountFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :view_count
  end
end
