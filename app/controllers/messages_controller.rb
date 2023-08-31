class MessagesController < ApplicationController

  def create
    @messages = []
    @conversation = Conversation.find_by(id: message_params[:conversation_id]) || Conversation.new(user: current_user, name: message_params[:body])
    @message_request = @conversation.messages.new(message_params)
    @conversation.save
    @messages << @message_request

    respond_to do |format|
      if @message_request.save
        @conversation = @message_request.conversation
        GPT_Response(@message_request)
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  
    private
  
    def message_params
      params.require(:message).permit(:user_id, :conversation_id, :body)
    end

    def GPT_Response(message)
      client = OpenAI::Client.new
  
      response = client.chat(
          parameters: {
              model: "gpt-3.5-turbo", 
              messages: [{ role: "user", content: message.body}], 
              temperature: 0.7,
          })
  
      @message_response = Message.new(
        user: message.user, 
        conversation: message.conversation, 
        body: response.dig("choices", 0, "message", "content"), 
        response: true)
  
        @message_response.save
      @messages << @message_response
    end

  end
  