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
  
  def after_sign_up_path_for(admins)
    new_agent_registration_path
  end
end