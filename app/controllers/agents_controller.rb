class AgentsController < ApplicationController
  before_filter :authenticate_admin!

  def join_chat

    @chat = Chat.find(params[:chat_id]) #Chat.find(Tiny::untiny(params[:id]))
    @user = ChatUser.user(session, current_agent.first_name)
    @messages = Message.all(:conditions => ["chat_id = ?", @chat.id.to_s])
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