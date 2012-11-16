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

    #retrieve any past chats for this customer
    customer_id = params[:customer_id]
    customer = Customer.find(customer_id)
    chat_history = customer.chats
    @chat_history_messages = Array.new
    chat_history.each { |chat|
      messages = Message.all(:conditions => ["chat_id = ?", chat.id.to_s])
      if !messages.empty?
        @chat_history_messages.append(messages)
      end
    }
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
    redirect_to agents_delete_index_path
  end

end