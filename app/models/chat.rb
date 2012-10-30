class Chat < ActiveRecord::Base
  attr_accessible :business_id, :chat, :customer_id, :date_of_chat, :keywords, :screenshots
end
