class Users::InvitationsController < Devise::InvitationsController

  def new
    if cannot?( :invite, User )
      raise CanCan::AccessDenied
    else
      build_resource
      render :new
    end
  end

  # GET /resource/invitation/accept?invitation_token=abcdef
  def edit
    render :edit
  end

  # PUT /resource/invitation
  def update
    self.resource = resource_class.accept_invitation!(resource_params)

    if resource.errors.empty?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message :notice, flash_message
      resource.add_role ENV['DEFAULT_ROLE'] if resource.roles.first.nil? if resource.class == User
      sign_in(resource_name, resource)
      respond_with resource, :location => after_accept_path_for(resource)
    else
      respond_with_navigational(resource){ render :edit }
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

