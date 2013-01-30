class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You do not have access to that page."
    redirect_to '/home#index'
  end

  private
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?
end
