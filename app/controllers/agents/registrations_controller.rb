class Agents::RegistrationsController < Devise::RegistrationsController
  # this isnt working
  before_filter :authenticate_admin!
   
  # says there is no business for the current user when there should be
  def new
    @cur_admin = current_admin
    @business = @cur_admin.business
    super
  end
  
  # POST /resource
  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        # removed this becuase we don't need to sign in the agent upon creation
        #sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  def after_sign_up_path_for(agent)
    admin_path(agent.business.admin)
  end

end
