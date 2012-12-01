class ApiController < ApplicationController

  protect_from_forgery :except => :authenticate # stop rails CSRF protection for this action

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
