class HomeController < ApplicationController
  def index
    redirect_to new_user_session_path if current_user.nil?
  end
end
