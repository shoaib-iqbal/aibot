class ConversationsController < ApplicationController

    def index
        @conversations = current_user&.conversations
        @conversation = if params[:id].present?
            current_user&.conversations.find(params[:id])
        else
            current_user&.conversations&.build
        end
    end

end