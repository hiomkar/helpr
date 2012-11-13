class Admins::RegistrationsController < Devise::RegistrationsController
   
   
  def create
    # converts the time into a saveable format
    params[:admin][:business_attributes].parse_time_select! :start_hour 
    params[:admin][:business_attributes].parse_time_select! :end_hour
    
    super
    
    # sets the admin_id for business
    business = Business.find_by_biz_url(params[:admin][:business_attributes][:biz_url])
    admin = Admin.find_by_email(params[:admin][:email])
    business.admin_id = admin.id
    business.save!
  end
  
  def after_sign_up_path_for(admins)
    new_agent_registration_path
  end
end