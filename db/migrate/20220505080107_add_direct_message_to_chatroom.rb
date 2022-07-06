class AddDirectMessageToChatroom < ActiveRecord::Migration[5.2]
  def change
    add_column :chatrooms, :direct_message, :boolean, null: false, default: false
  end
end