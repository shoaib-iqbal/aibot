class Message < ApplicationRecord
  after_create_commit -> { broadcast_append_to 'messages' }

  enum role: { system: 0, bot: 1 }, _default: 'system'

  belongs_to :conversation, inverse_of: :messages

  def to_json
    role = role="system" ? 'user' : 'system'
    {role: role, content: body}
  end
  
  def get_reply
    Gpt.new.generate_response(self)
  end
  
end
