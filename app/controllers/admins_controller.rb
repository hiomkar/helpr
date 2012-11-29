require 'apis/WordCloudMaker'

class AdminsController < ApplicationController
  before_filter :authenticate_admin!, :only => [:index, :edit, :show, :destroy]
  
  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admins }
    end
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
    @admin = Admin.find(params[:id])
    @business = @admin.business

    #WHERE chats.business_id = "+@business.id.to_s+"

    #messages_array = Message.find_by_sql "select * from messages INNER JOIN chats ON messages.chat_id=chats.id "

    messages_array = Message.find_by_sql "select * from messages INNER JOIN chats ON messages.chat_id=chats.id WHERE chats.business_id = "+@business.id.to_s+""
    #messages_array = Message.joins(:chat).where('chats.business_id', @business.id).all
    #messages_array = Message.all(:conditions => ["created_at like ?", "2012-11-16%"])

    messages_text_block = String.new

    messages_array.each { |msg|
      if msg.message
        messages_text_block += " "+msg.message
      end
    }

    messages_text_block.gsub!(/(?:f|ht)tps?:\/[^\s]+/, '')

    post_args = {
        'height' => "500",
        'textblock' => messages_text_block,
        'width' => "500",
        'config' => "n/a"
    }

    client = WordCloudMaker.new

    @data = client.makeWordCloud(post_args['height'], post_args['textblock'], post_args['width'])

    #----------------

    @link = root_url + "customers/new/?business=" + @business.biz_url

    #---visualization--------------------
    chats = @admin.business.chats

    @graph = [['x', 'Number of Chats']]

    for hour in 0..24
      chats_count = 0

      chats.each do |chat|
        chat_hour = chat.created_at.hour
        if (hour == chat_hour)
          chats_count += 1
        end
      end

      @graph.push([hour, chats_count])
    end




    #-------------------------------------


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin }
    end
  end

  # GET /admins/new
  # GET /admins/new.json
  def new
    @admin = Admin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin }
    end
  end

  # GET /admins/1/edit
  def edit
    @admin = Admin.find(params[:id])
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(params[:admin])


    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
        format.json { render json: @admin, status: :created, location: @admin }
      else
        format.html { render action: "new" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admins/1
  # PUT /admins/1.json
  def update
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to admins_url }
      format.json { head :no_content }
    end
  end
end
