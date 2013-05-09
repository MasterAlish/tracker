class Users::InvitationsController < Devise::InvitationsController

  def new
    if cannot?( :invite, User )
      raise CanCan::AccessDenied
    else
      super
    end
  end

  def create
    if cannot?( :invite, User )
      raise CanCan::AccessDenied
    else
      super
    end
  end

  def after_invite_path_for(resource)
    root_path
  end

  def after_accept_path_for(resource)
    root_path
  end

end

