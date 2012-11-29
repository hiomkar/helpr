class ApiController < ApplicationController

  protect_from_forgery :except => :authenticate # stop rails CSRF protection for this action

  def update_first_name
    if params[:user_id] != nil && params[:first_name] != nil
      user = ChatUser.find(params[:user_id])
      old_first_name = user.first_name
      user.first_name = params[:first_name]
      if user.save
        chat = Chat.find(params[:chat_id])
        payload = { :old_first_name => old_first_name, :first_name => user.first_name, :user_id => user.id }
        Pusher["presence-" + chat.channel].trigger('updated_first_name', payload)
        render :text => "SAVED"
      else
        render :text => "ERROR"
      end
    else
      render :text => "ERROR"
    end
  end

  def post_message
    chat = Chat.find(params[:chat_id])
    message = Message.new
    message.chat_id = chat.id

    user = ChatUser.user(session)
    message.user_id = user.id
    
    # escapes &, <, > in rails
    message.message = CGI::escapeHTML(params[:message])

    payload = message.attributes
    payload[:user] = user.attributes

    if message.save
      Pusher["presence-" + chat.channel].trigger('send_message', payload)
      render :text => "sent"
    else
      render :text => "failed"
    end
  end

  def typing_status
    if params[:chat_id] != nil && params[:status] != nil
      chat = Chat.find(params[:chat_id])
      user = ChatUser.user(session)

      payload = { :user => user.attributes, :status => params[:status] }
      Pusher["presence-" + chat.channel].trigger('typing_status', payload)
    end
    render :text => ""
  end

  def authenticate
    if params[:user_id]
      user = ChatUser.find(params[:user_id])
      auth = Pusher[params[:channel_name]].authenticate(params[:socket_id],
                                                        :user_id => user.id,
                                                        :chat_user => user.attributes
      )
      render :json => auth
    else
      render :text => "Not authorized", :status => '403'
    end
  end

  def upload_file
    chat = Chat.find(params[:chat_id])
    message = Message.create(params[:message])
    message.chat_id = chat.id

    user = ChatUser.user(session)
    message.user_id = user.id
    download_url = message.shared_file.url(:download => true)
    file_name = message.shared_file_file_name
    message.message = "<a href=\""+download_url+"\" target='_blank'>"+file_name+"</a>"

    payload = message.attributes
    payload[:user] = user.attributes

    if message.save
      Pusher["presence-" + chat.channel].trigger('send_message', payload)

      render :text => "file uploaded"
    else
      render :text => "upload failed"
    end
  end
end
