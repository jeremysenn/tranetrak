class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def new
    render :layout => 'login'
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.is_trainer?
      @user.trainer = Trainer.new(:first_name => @user.first_name, :last_name => @user.last_name, :email => @user.email)
    elsif @user.is_client?
      @user.client = Client.find_by_email(@user.email)
      if @user.client.blank?
        @user.client = Client.new(:first_name => @user.first_name, :last_name => @user.last_name, :email => @user.email)
      end
    end
    if @user.save
      session[:user_id] = @user.id
      @user.welcome_email
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new', :layout => 'login'
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.is_trainer? and @user.trainer.pictures.empty?
      @user.trainer.pictures.build
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      if @user.is_trainer?
        @user.trainer.update_attributes(:first_name => @user.first_name, :last_name => @user.last_name, :email => @user.email)
      elsif @user.is_client?
        @user.client.update_attributes(:first_name => @user.first_name, :last_name => @user.last_name, :email => @user.email)
      end
      redirect_to root_url, :notice => "User profile has been updated."
    else
      render :action => 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end
