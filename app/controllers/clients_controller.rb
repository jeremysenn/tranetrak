class ClientsController < ApplicationController
  load_and_authorize_resource

  # GET /clients
  # GET /clients.json
  def index
    respond_to do |format|
      format.html {
        unless current_user.username == 'jeremysenn'
          @clients = current_user.trainer.clients.order(:first_name).page(params[:page]).per(20)
        else
          @clients = Client.order(:first_name).page(params[:page]).per(20)
        end
      }
      format.json {
        @clients = Client.order(:first_name)
        render json: @clients
        }
    end
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      redirect_to @client, :notice => "Successfully created client."
    else
      render :action => 'new'
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
      redirect_to @client, :notice  => "Successfully updated client."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_url, :notice => "Successfully destroyed client."
  end
end
