class CreateScouts < ActiveRecord::Migration
  def change
    create_table :scouts do |t|
      t.references :user, index: true, null: false
      t.string :company,    null: false
      t.string :last_name,  null: false
      t.string :first_name, null: false
      t.string :zip,        null: false
      t.string :prefecture, null: false
      t.string :city,       null: false
      t.string :address,    null: false
      t.string :building,   null: false, default: ""
      t.string :phone,      null: false

      t.timestamps
    end
  end
end
