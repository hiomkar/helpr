class Admins::RegistrationsController < Devise::RegistrationsController
   
  def update
    # converts the time into a saveable format
    params[:admin][:business_attributes].parse_time_select! :start_hour 
    params[:admin][:business_attributes].parse_time_select! :end_hour
    
    super
  end
   
  def create
    # converts the time into a saveable format
    params[:admin][:business_attributes].parse_time_select! :start_hour 
    params[:admin][:business_attributes].parse_time_select! :end_hour
    
    super
  end
  
  def after_sign_up_path_for(admin)
    admin_path(admin)
  end
  
  def after_update_path_for(admin)
    admin_path(admin)
  end
end