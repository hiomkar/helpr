require "router/agent_router"

class CustomersController < ApplicationController

  def new
    @customer = Customer.new
    business_param = params[:business]
    if business_param!= nil
      @business = Business.find_by_biz_url(business_param)
      #TODO redirect to a custom error page instead of employee login page
      if @business == nil
        redirect_to "/"
      end
    else
      redirect_to "/"
    end
  end
  

  def create
    #create chat object here
    @customer = Customer.new(params[:customer])

    input_customer_email = params[:customer][:email]
    existing_customer = Customer.find_by_email(input_customer_email)

    if input_customer_email != nil && existing_customer != nil
      @customer = existing_customer
    else
      # create customer here
      #@customer = Customer.new(params[:chat][:customer])
      #@customer.save
      @customer = nil
    end

    #@chat.customer = @customer

    @chat.channel = "message_channel_" + @chat.id.to_s
    @user = ChatUser.user(session, @customer.first_name)
    @messages = Message.for_chat(@chat.id).order_by_time

    #@chat.save

    #business_url = params[:business_url]
    #@business = Business.find_by_biz_url(business_url)
    #@chat.business = @business
     @customer.save
      #params[:chat][:customer] = nil
         

    agent_id = AgentRouter.select_agent(@chat.business)

    #notify agents of incoming chat
    channel_name = "cc-new-chat-channel-"+agent_id.to_s
    event_name = "customer-call-event"
    Pusher[channel_name].trigger(event_name, {:chat_id => @chat.id.to_s, :customer_name => @chat.customer.first_name, :customer_id => @chat.customer.id})
  
    render 'customers/index'
    
  end

end
