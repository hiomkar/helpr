class Phrase < ActiveRecord::Base
  attr_accessible :business_id, :phrase

  belongs_to :business
  
  #Scopes
  scope :for_business, lambda {|business_id| where("business_id = ?", business_id) }
  
end
