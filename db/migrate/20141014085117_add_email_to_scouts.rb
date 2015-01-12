class AddEmailToScouts < ActiveRecord::Migration
  def change
    add_column :scouts, :email, :string
  end
end
