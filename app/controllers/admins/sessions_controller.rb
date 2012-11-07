class Admins::SessionsController < Devise::SessionsController
  def resource_name
    :admin
  end

  def resource
    @resource ||= Admin.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:admin]
  end
  
  def after_sign_in_path_for(admins)
    admins_path
  end
end