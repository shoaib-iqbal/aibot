class MessagesController < ApplicationController

  def create
    @conversation = current_user.conversations.find_by(id: message_params[:conversation_id]) || Conversation.new(user: current_user, name: message_params[:body].first(8))
    @request_message = @conversation.messages.new(message_params)

    respond_to do |format|
      if @request_message.save
        @get_resposne = @request_message.get_reply
        @messages = []
        @messages << @request_message << @get_resposne
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
     
    private
  
    def message_params
      params.require(:message).permit(:conversation_id, :body)
    end

  end
  