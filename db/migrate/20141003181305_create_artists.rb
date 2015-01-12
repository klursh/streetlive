class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.references :user, index: true, null: false
      t.string :name,        null: false
      t.integer :view_count, null: false, default: 0
      t.string :location,    null: false, default: ""

      t.timestamps
    end
  end
end
