class RenameResponseToIdInMessagesToRespondsToId < ActiveRecord::Migration
  def change
    rename_column :messages, :response_to_id, :responds_to_id
  end
end
