class Phrase < ActiveRecord::Base
  attr_accessible :business_id, :phrase

  belongs_to :business
end
