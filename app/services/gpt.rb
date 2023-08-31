class Gpt
  def generate_response(message)
      client = OpenAI::Client.new
  
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo", 
          messages: message.conversation.messages.map(&:to_json), 
          temperature: 0.7,
        })
        
      response_content = response.dig("choices", 0, "message", "content") || "Error: No Response From API"
  
      message_response = Message.new(
        conversation: message.conversation, 
        body: response_content,
        role: 1
      )
  
      message_response.save
      message_response
  end
end
  