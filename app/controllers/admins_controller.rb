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
    @admin = current_admin
    @business = @admin.business
    @agents = @business.agents
    @phrases = @business.phrases
    
    messages_array = Message.for_business(@business.id)

    @messages_array = messages_array
    
    messages_text_block = String.new

    messages_array.each { |msg|
      if msg.message
        if !msg.message.to_s.include? "has left the conversation."
          messages_text_block += " "+msg.message
        end
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

    #---google visualization api data creation--------------------
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
