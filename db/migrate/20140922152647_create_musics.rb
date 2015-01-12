class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.references :user, index: true, null: false
      t.string :youtube_content_id, null: false
      t.integer :view_count,        null: false, default: 0
      t.string :title,              null: false, default: ""
      t.string :description,        null: false, default: ""

      t.timestamps
    end
  end
end
