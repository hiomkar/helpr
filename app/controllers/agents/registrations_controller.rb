class Agents::RegistrationsController < Devise::RegistrationsController
  # this isnt working
  before_filter :authenticate_admin!
   
  # says there is no business for the current user when there should be
  def new
    @admin = current_admin
    @cur_admin = Admin.find(@admin.id)
    @business = @cur_admin.business
    #@admin = @business.admin
    super
  end

end

# Need to
#--get association between businesses and agents working
#--don't sign in after creating agent and leave admin signed in
#--redirect to create agent page to create another agent