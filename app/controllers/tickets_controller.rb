class TicketsController < ApplicationController
  include TicketsHelper
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def index
  end

  def signed_in_user
    if current_user.nil?
      store_location
      redirect_to new_user_session_path, notice: "Please sign in."
    end
  end

  def correct_user
  end

  def admin_user
  end
end
