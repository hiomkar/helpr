class CustomersController < ApplicationController
  # GET /customers
  # GET /customers.json
  def index

    #create chat object here
    @chat = Chat.new
    customer = Customer.new
    #use params[:attribute] for the following fields
    customer.email = "customer@customer.com"
    customer.first_name = "John"
    customer.save

    @chat.customer = customer
    @chat.save

    @chat.channel = "message_channel_" + @chat.id.to_s
    @user = ChatUser.user(session, customer.first_name)
    @messages = Message.all(:conditions => ["chat_id = ?", @chat.id.to_s])

    @chat.save

    #notify agents of incoming chat
    Pusher['cc-new-chat-channel'].trigger('customer-call-event', {:chat_id => @chat.id.to_s, :user_id => @chat.customer.first_name})

  end

end
