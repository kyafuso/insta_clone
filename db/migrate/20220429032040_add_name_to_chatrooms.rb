class AddNameToChatrooms < ActiveRecord::Migration[5.2]
  def change
    add_column :chatrooms, :name, :string, :null => false
  end
end
