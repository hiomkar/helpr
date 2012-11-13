class Agents::RegistrationsController < Devise::RegistrationsController
  # this isnt working
  before_filter :authenticate_admin!
   
  # says there is no business for the current user when there should be
  def new
    @cur_admin = current_admin
    @business = @cur_admin.business
    super
  end

end

# Need to
#--get association between businesses and agents working
#--don't sign in after creating agent and leave admin signed in
#--redirect to create agent page to create another agent