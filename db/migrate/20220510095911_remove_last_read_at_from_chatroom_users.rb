class RemoveLastReadAtFromChatroomUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :chatroom_users, :last_read_at, :datetime
  end
end
