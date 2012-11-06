class Agents::SessionsController < Devise::SessionsController
  def resource_name
    :agent
  end

  def resource
    @resource ||= Agent.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:agent]
  end
  
  def after_sign_in_path_for(agents)
    render "agents/index"
  end
end