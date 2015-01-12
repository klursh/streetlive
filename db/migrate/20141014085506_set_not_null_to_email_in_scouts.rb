class SetNotNullToEmailInScouts < ActiveRecord::Migration
  def change
    change_column :scouts, :email, :string, null: false
  end
end
