class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin?, only: [:destroy, :index]

  def index
    authorize! :index, current_user,
               :message => 'Not authorized as an administrator.'
    @users=User.all
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:warning]= "User deleted successfully"
    redirect_to users_path
  end

  def is_admin?
    if !current_user.has_role? :admin
        redirect_to root_path
    end
  end
end
