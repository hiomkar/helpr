class PhrasesController < ApplicationController
  before_filter :authenticate_admin!
  
  # GET /phrases
  # GET /phrases.json
  def index
    @business = current_admin.business
    @phrases = Phrase.for_business(@business.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @phrases }
    end
  end

  # GET /phrases/1
  # GET /phrases/1.json
  def show
    @phrase = Phrase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @phrase }
    end
  end

  # GET /phrases/new
  # GET /phrases/new.json
  def new
    @phrase = Phrase.new
    
    @business = current_admin.business

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @phrase }
    end
  end

  # GET /phrases/1/edit
  def edit
    @phrase = Phrase.find(params[:id])
  end

  # POST /phrases
  # POST /phrases.json
  def create
    @phrase = Phrase.new(params[:phrase])

    respond_to do |format|
      if @phrase.save
        format.html { redirect_to new_phrase_path, notice: 'Phrase was successfully created.' }
        format.json { render json: @phrase, status: :created, location: @phrase }
      else
        format.html { render action: "new" }
        format.json { render json: @phrase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /phrases/1
  # PUT /phrases/1.json
  def update
    @phrase = Phrase.find(params[:id])

    respond_to do |format|
      if @phrase.update_attributes(params[:phrase])
        format.html { redirect_to @phrase, notice: 'Phrase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @phrase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phrases/1
  # DELETE /phrases/1.json
  def destroy
    @phrase = Phrase.find(params[:id])
    @phrase.destroy

    respond_to do |format|
      format.html { redirect_to phrases_url }
      format.json { head :no_content }
    end
  end
end
