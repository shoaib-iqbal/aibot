class ConversationsController < ApplicationController

    def index
        @conversations = current_user&.conversations
        @conversation = current_user&.conversations&.build
        @conversation_messages = Conversation.find(Base64.urlsafe_decode64(params[:id])) if params[:id]
    end
end