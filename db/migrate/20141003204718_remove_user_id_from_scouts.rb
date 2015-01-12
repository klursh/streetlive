class RemoveUserIdFromScouts < ActiveRecord::Migration
  def change
    remove_column :scouts, :user_id
  end
end
