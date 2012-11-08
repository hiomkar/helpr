class CustomersController < ApplicationController
  # GET /customers
  # GET /customers.json
  def index

    #create chat object here
    @chat = Chat.new
    @chat.owner = ChatUser.user(session)
    @chat.save
    @chat.channel = "message_channel_" + @chat.id.to_s
    @user = ChatUser.user(session)
    @messages = Message.all(:conditions => ["chat_id = ?", @chat.id.to_s])
    @chat.save
    Pusher['cc-new-chat-channel'].trigger('customer-call-event', {:chat_id => @chat.id.to_s, :user_id => @chat.owner.nickname})

  end

end
