class AddIntroductionToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :introduction, :string, default: "", null: false
  end
end
