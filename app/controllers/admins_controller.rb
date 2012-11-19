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

    messages_array = Message.all(:conditions => ["created_at like ?", Date.today.to_s+"%"])
    #messages_array = Message.all(:conditions => ["created_at like ?", "2012-11-16%"])

    messages_text_block = String.new

    messages_array.each {|msg| messages_text_block += " "+msg.message }

    post_args = {
        'height' => "500",
        'textblock' => messages_text_block,
        'width' => "500",
        'config' => "n/a"
    }

    client = WordCloudMaker.new("xdychn3yvjk2ywk9ux8ks2x3xsv3fw", "itof6mgqqqvietyy5apdva4ugdsxdf")

    @data = client.makeWordCloud(post_args['height'], post_args['textblock'], post_args['width'])

    #----------------


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
