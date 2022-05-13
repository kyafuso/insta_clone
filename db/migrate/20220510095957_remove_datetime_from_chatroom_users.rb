class RemoveDatetimeFromChatroomUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :chatroom_users, :datetime, :datetime
  end
end
