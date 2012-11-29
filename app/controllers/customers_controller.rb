require "router/agent_router"

class CustomersController < ApplicationController
  def new
    @customer = Customer.new
    business_param = params[:business]
    if business_param!= nil
      @business = Business.find_by_biz_url(business_param)
      time = Time.now
      if (time > @business.start_hour && time < @business.end_hour)
           @available = true
      else
         #show unavailability
        @availability = "We are not available at this time! You can contact us between: "+@business.start_hour.strftime("%I:%M%p").to_s+" & "+@business.end_hour.strftime("%I:%M%p").to_s
      end

      #TODO redirect to a custom error page instead of employee login page
      if @business == nil
        redirect_to "/"
      end
    else
      redirect_to "/"
    end
  end

  def index

    #find if customer already exists or else create new entry
    input_customer_email = params[:customer][:email]
    existing_customer = Customer.find_by_email(input_customer_email)
    if input_customer_email != nil && existing_customer != nil
      @customer = existing_customer
    else
      @customer = Customer.new
      @customer.first_name = params[:customer][:first_name]
      @customer.last_name = params[:customer][:first_name]
      @customer.email = params[:customer][:email]
      @customer.phone = params[:customer][:phone]
    end
    @customer.save

    #create a new chat instance
    @chat = Chat.new
    @chat.business_id = params[:customer][:chat][:business_id]
    @chat.customer_id = @customer.id
    @chat.save
    @chat.channel = "message_channel_" + @chat.id.to_s
    @chat.save

    #find user in session or create new user in session
    @user = ChatUser.user(session, @customer.first_name)
    #retrieve any existing messages sent to the chat room
    @messages = Message.all(:conditions => ["chat_id = ?", @chat.id.to_s])

    #retrieve the business association of this chat
    @business = @chat.business

    #select an agent of this business and route the chat to that agent
    agent_id = AgentRouter.select_agent(@business)

    #notify agents of incoming chat
    channel_name = "cc-new-chat-channel-"+agent_id.to_s
    event_name = "customer-call-event"
    Pusher[channel_name].trigger(event_name, {:chat_id => @chat.id.to_s, :customer_name => @chat.customer.first_name, :customer_id => @chat.customer.id})

  end

end
