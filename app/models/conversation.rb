class Conversation < ApplicationRecord
  belongs_to :user, inverse_of: :conversations
  has_many :messages, dependent: :destroy, inverse_of: :conversation
end
