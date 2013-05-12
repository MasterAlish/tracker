module ApplicationHelper
  def store_location
    session[:user_return_to] = request.fullpath
  end

  def signed_in_user
    if current_user.nil?
      store_location
      redirect_to new_user_session_path, notice: "Please sign in."
    end
  end

  def correct_user
  end

  def is_admin?
    unless current_user.has_role? :admin
      redirect_to root_path
    end
  end
end
