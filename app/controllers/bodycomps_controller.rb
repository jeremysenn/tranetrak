class BodycompsController < ApplicationController
  load_and_authorize_resource

  # GET /bodycomps
  # GET /bodycomps.json
  def index
    unless current_user.username == 'jeremysenn'
      @bodycomps = current_user.trainer.bodycomps.order(:date).page(params[:page]).per(20)
    else
      @bodycomps = Bodycomp.order(:date).page(params[:page]).per(20)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bodycomps }
    end
  end

  # GET /bodycomps/1
  # GET /bodycomps/1.json
  def show
    @bodycomp = Bodycomp.find(params[:id])
    @bodycomps = @bodycomp.client.bodycomps.last(15)
    @client = @bodycomp.client

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bodycomp }
    end
  end

  # GET /bodycomps/new
  # GET /bodycomps/new.json
  def new
    @bodycomp = Bodycomp.new
#    @bodycomp.pictures.build
    @bodycomp.date = Date.today
    unless params[:client].blank?
      @client = current_user.trainer.clients.find(params[:client])
      unless @client.blank?
        @bodycomp.client_id = @client.id
        @bodycomp.age = @client.dob_age
        @bodycomp.sex = @client.sex
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bodycomp }
    end
  end

  # GET /bodycomps/1/edit
  def edit
    @bodycomp = Bodycomp.find(params[:id])
#    @bodycomp.pictures.build if @bodycomp.pictures.blank?
  end

  # POST /bodycomps
  # POST /bodycomps.json
  def create
    @bodycomp = Bodycomp.new(params[:bodycomp])

    respond_to do |format|
      if @bodycomp.save
        @bodycomp.bodycomp_summary_email
        format.html { redirect_to @bodycomp, notice: 'Bodycomp was successfully created.' }
        format.json { render json: @bodycomp, status: :created, location: @bodycomp }
      else
        format.html { render action: "new" }
        format.json { render json: @bodycomp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bodycomps/1
  # PUT /bodycomps/1.json
  def update
    @bodycomp = Bodycomp.find(params[:id])

    respond_to do |format|
      if @bodycomp.update_attributes(params[:bodycomp])
        @bodycomp.bodycomp_summary_email
        format.html { redirect_to @bodycomp, notice: 'Bodycomp was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bodycomp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bodycomps/1
  # DELETE /bodycomps/1.json
  def destroy
    @bodycomp = Bodycomp.find(params[:id])
    @bodycomp.destroy

    respond_to do |format|
      format.html { redirect_to bodycomps_url }
      format.json { head :ok }
    end
  end

  def bodycomp_graphs
    @bodycomp = Bodycomp.find(params[:id])
    @bodycomps = @bodycomp.client.bodycomps
  end

  def skinfold_graphs
    @bodycomp = Bodycomp.find(params[:id])
    @bodycomps = @bodycomp.client.bodycomps
  end

  def girth_graphs
    @bodycomp = Bodycomp.find(params[:id])
    @bodycomps = @bodycomp.client.bodycomps
  end
end
