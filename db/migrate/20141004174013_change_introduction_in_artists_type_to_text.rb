class ChangeIntroductionInArtistsTypeToText < ActiveRecord::Migration
  def change
    change_column :artists, :introduction, :text
  end
end
