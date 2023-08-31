class Message < ApplicationRecord

  after_create_commit -> { broadcast_append_to 'messages' }

  belongs_to :user
  belongs_to :conversation

  def to_json
    role = response? ? 'system' : 'user'
    {role: role, content: body}
  end
  
end
