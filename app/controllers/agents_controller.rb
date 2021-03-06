class AgentsController < ApplicationController

  before_filter :authenticate_agent!, :only => [:index, :join_chat]

  def index
    @channel_name = "cc-new-chat-channel-"+current_agent.id.to_s
    @agent = current_agent
    @phrases = Phrase.for_business(@agent.business.id)
    @chat_history_messages = Hash.new
    @file_messages = Array.new
    
    @show_waiting = true
  end
  
  def show
    
  end

  def join_chat
    @channel_name = "cc-new-chat-channel-"+current_agent.id.to_s
    @agent = current_agent
    @chat = Chat.find(params[:chat_id])
    @user = ChatUser.user(session, current_agent.first_name)
    @business = @agent.business

    @phrases = Phrase.for_business(@agent.business.id)

    @show_waiting = false

    #retrieve any past chats for this customer
    customer_id = params[:customer_id]
    customer = Customer.find(customer_id)
    chat_history = customer.chats
    @chat_history_messages = Hash.new
    @messages = Message.for_chat(@chat.id)

    customers_messages = Array.new

    chat_history.each { |chat|
      # add all messages from each chat to one array
      customers_messages.concat(chat.messages)

      messages = Message.for_chat(chat.id).for_business(@business.id)
      if !messages.empty?
        @chat_history_messages[chat.created_at] = messages
      end
    }

    # get all the messages that contain files from this customer's past messages
    @file_messages = Array.new

    customers_messages.map{ |m|
      if !m.shared_file_file_name.nil?
        if !m.message.nil?
        then @file_messages.push(m)
        end
      end
    }

    @customer = customer

    render "agents/index"
  end

  def view_all
    @business = current_admin.business
    @agents = Agent.for_business(@business.id)
  end

  def destroy
    # retrieve the employee to be destroyed
    @agent = Agent.find(params[:id])
    @agent.destroy  # detroy the employee

    # flash notice that says employee was removed
    flash[:notice] = "Successfully removed #{@agent.first_name} from the system."
    # go to the employees index page
    redirect_to admin_path(current_admin)
  end

end