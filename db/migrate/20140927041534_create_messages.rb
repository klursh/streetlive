class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user,   index: true, null: false
      t.references :sender, index: true     # ユーザが退会したときはnullにする
      t.string :content, null: false
      t.references :response_to, index: true

      t.timestamps
    end
  end
end
