# == Schema Information
#
# Table name: chatrooms
#
#  id             :bigint           not null, primary key
#  direct_message :boolean          default(FALSE), not null
#  name           :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end