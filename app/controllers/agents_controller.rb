class AgentsController < ApplicationController

  before_filter :authenticate_agent!

  def index
    @channel_name = "cc-new-chat-channel-"+current_agent.id.to_s
    @agent = current_agent
  end

  def join_chat
    @channel_name = "cc-new-chat-channel-"+current_agent.id.to_s
    @agent = current_agent
    @chat = Chat.find(params[:chat_id])
    @user = ChatUser.user(session, current_agent.first_name)
    @messages = Message.all(:conditions => ["chat_id = ?", @chat.id.to_s])
    render "agents/index"
  end

end