class Message < ApplicationRecord
  after_create_commit -> { broadcast_append_to 'messages' }

  enum role: { user: 0, system: 1 }, _default: 'user'

  belongs_to :conversation, inverse_of: :messages

  def to_json
    {role: role, content: body}
  end
  
  def user
    conversation.user
  end
  
  def get_reply
    Gpt.new.generate_response(self)
  end
  
end
