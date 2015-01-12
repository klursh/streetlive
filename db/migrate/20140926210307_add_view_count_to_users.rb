class AddViewCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :view_count, :integer, null: false, default: 0
  end
end
