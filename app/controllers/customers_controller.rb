require "router/agent_router"

class CustomersController < ApplicationController

  def new
    business_param = params[:business]
    if business_param!= nil
      @business = Business.find_by_biz_url(business_param)
      if @business == nil
        redirect_to "/"
      end
    else
      redirect_to "/"
    end

  end

  def index

    #create chat object here
    @chat = Chat.new
    customer = Customer.new

    #TODO do input validation here
    customer.email = params[:customer_email]
    customer.first_name = params[:customer_name]
    customer.save

    @chat.customer = customer
    @chat.save

    @chat.channel = "message_channel_" + @chat.id.to_s
    @user = ChatUser.user(session, customer.first_name)
    @messages = Message.all(:conditions => ["chat_id = ?", @chat.id.to_s])

    @chat.save

    business_url = params[:business_url]
    @business = Business.find_by_biz_url(business_url)

    agent_id = AgentRouter.select_agent

    #notify agents of incoming chat
    channel_name = "cc-new-chat-channel-"+agent_id.to_s
    event_name = "customer-call-event"
    Pusher[channel_name].trigger(event_name, {:chat_id => @chat.id.to_s, :user_id => @chat.customer.first_name})

  end

end
