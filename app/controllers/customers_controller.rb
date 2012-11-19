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

    input_customer_email = params[:customer_email]
    existing_customer = Customer.find_by_email(input_customer_email)

    if input_customer_email != nil && existing_customer != nil
      customer = existing_customer
    else
      customer = Customer.new
      #TODO do input validation here
      customer.email = params[:customer_email]
      customer.first_name = params[:customer_name]
      customer.save
    end

    @chat.customer = customer
    @chat.save

    @chat.channel = "message_channel_" + @chat.id.to_s
    @user = ChatUser.user(session, customer.first_name)
    @messages = Message.all(:conditions => ["chat_id = ?", @chat.id.to_s])

    @chat.save

    business_url = params[:business_url]
    @business = Business.find_by_biz_url(business_url)
    @chat.business = @business
    @chat.save

    agent_id = AgentRouter.select_agent(@business)

    #notify agents of incoming chat
    channel_name = "cc-new-chat-channel-"+agent_id.to_s
    event_name = "customer-call-event"
    Pusher[channel_name].trigger(event_name, {:chat_id => @chat.id.to_s, :customer_name => @chat.customer.first_name, :customer_id => @chat.customer.id})

  end

end
