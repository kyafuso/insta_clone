class CreateJoinChatrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :join_chatrooms do |t|
      t.references :user, foreign_key: true
      t.references :chatroom, foreign_key: true

      t.timestamps
    end
  end
end
