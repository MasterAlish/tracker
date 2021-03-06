class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  rescue_from Gmail::Client::ConnectionError do |exc|
    flash[:error] = 'Could not connect to Gmail.'
    redirect_to stored_location_for(current_user) || root_path
  end

  def after_sign_in_path_for(resource)
    #sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
    #if request.referer == sign_in_url
    #  super
    #else
      stored_location_for(resource) ||  root_path
    #end
  end

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
end
