class AgentsController < ApplicationController
  before_filter :authenticate_agent!

  def join_chat


    @chat = Chat.find(params[:chat_id]) #Chat.find(Tiny::untiny(params[:id]))
    @user = ChatUser.user(session)
    @messages = Message.all(:conditions => ["chat_id = ?", @chat.id.to_s])

    render "agents/index"
  end


end