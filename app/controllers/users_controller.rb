class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin?, only: [:destroy, :index, :edit]

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
    unless current_user.has_role? :admin
        redirect_to root_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    user = params[:user]
    @user.name=user[:name]
    @user.email=user[:email]

    @user.roles.clear
    @user.add_role params[:user_role]

    @user.save
    flash[:success]="Saved successfully"
    redirect_to users_path
  end
end
