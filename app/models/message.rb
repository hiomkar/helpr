class Message < ActiveRecord::Base

  attr_accessible :shared_file

  belongs_to :chat
  has_one :business, :through => :chat

  has_attached_file :shared_file,
                    :storage => :dropbox,
                    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml"

  # Scope
   scope :for_chat, lambda {|chat_id| where("chat_id = ?", chat_id) }
   scope :order_by_time, order('created_at')
   scope :for_business, lambda {|business_id| joins(:business).where("business_id = ?", business_id) }

  
end
