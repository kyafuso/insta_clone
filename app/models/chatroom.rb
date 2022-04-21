# == Schema Information
#
# Table name: chatrooms
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chatroom < ApplicationRecord
  has_many :join_chatrooms, dependent: :destroy
  has_many :users, through: :join_chatrooms
end
