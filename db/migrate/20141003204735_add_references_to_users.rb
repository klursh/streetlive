class AddReferencesToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :artist, index: true
      t.references :scout,  index: true
    end
  end
end
