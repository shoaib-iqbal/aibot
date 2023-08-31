class MessagesController < ApplicationController

  def create
    @messages = []
    @conversation = Conversation.find_by(id: message_params[:conversation_id]) || Conversation.new(user: current_user, name: message_params[:body])
    @message_request = @conversation.messages.new(message_params)

    @messages << @message_request
    respond_to do |format|
      if @message_request.save && @conversation.save
        @conversation = @message_request.conversation
        GPT_Response(@message_request)
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
     
  def GPT_Response(message)
    @message_response = Gpt.new.generate_response(message)
    @messages << @message_response
  end
  
    private
  
    def message_params
      params.require(:message).permit(:user_id, :conversation_id, :body)
    end

  end
  