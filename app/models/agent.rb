class Agent < ActiveRecord::Base
  attr_accessible :business_id, :first_name, :last_name, :password, :username
end