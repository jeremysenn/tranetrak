class BodycompsController < ApplicationController
  # GET /bodycomps
  # GET /bodycomps.json
  def index
    unless current_user.username == 'jeremysenn'
      @bodycomps = current_user.trainer.clients
    else
      @bodycomps = Bodycomp.all
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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bodycomp }
    end
  end

  # GET /bodycomps/new
  # GET /bodycomps/new.json
  def new
    @bodycomp = Bodycomp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bodycomp }
    end
  end

  # GET /bodycomps/1/edit
  def edit
    @bodycomp = Bodycomp.find(params[:id])
  end

  # POST /bodycomps
  # POST /bodycomps.json
  def create
    @bodycomp = Bodycomp.new(params[:bodycomp])

    respond_to do |format|
      if @bodycomp.save
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
end
