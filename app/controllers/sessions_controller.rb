class SessionsController < ApplicationController
  layout 'login'

  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      unless user.is_client?
        redirect_to_target_or_default root_url, :notice => "Logged in successfully."
      else
        redirect_to_target_or_default client_path(user.client), :notice => "Logged in successfully."
      end
    else
      flash.now[:alert] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login', :notice => "You have been logged out."
  end
end
