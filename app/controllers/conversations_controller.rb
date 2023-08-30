class ConversationsController < ApplicationController

    def index
        @conversations = current_user.conversations
        @conversation = current_user.conversations.build
    end
    def new
        @conversation = Conversation.create(
            user_id: current_user.id,
            name: "Random #{current_user.id}"
        )
        redirect_to root_path(id: @conversation.id)
    end

end