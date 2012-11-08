class Admins::RegistrationsController < Devise::RegistrationsController
   
  def create
    # converts the time into a saveable format
    params[:admin][:business_attributes].parse_time_select! :start_hour 
    params[:admin][:business_attributes].parse_time_select! :end_hour
    super
  end
end