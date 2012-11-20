# custom class to route a failed sign in to the home page

class CustomFailure < Devise::FailureApp
  
  def redirect_url
    return super unless [:admin, :agent].include?(scope) #make it specific to a scope
    root_url
  end

  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end