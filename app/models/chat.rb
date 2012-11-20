class Chat < ActiveRecord::Base

  belongs_to :business
  belongs_to :customer

  has_many :messages
  
  attr_accessible :business_id, :chat, :customer_id, :date_of_chat, :keywords, :screenshots, :channel
   
  accepts_nested_attributes_for :customer

end
