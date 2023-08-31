class Message < ApplicationRecor
  after_create_commit -> { broadcast_append_to 'messages' }

  belongs_to :user
  belongs_to :conversation, inverse_of: :messages

  def to_json
    role = response? ? 'system' : 'user'
    {role: role, content: body}
  end
  # def user
  #   conversation.user
  # end
  
end
