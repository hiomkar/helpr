class Business < ActiveRecord::Base
  attr_accessible :admin_id, :biz_name, :biz_url, :end_hour, :existing_biz_url, :start_hour 
  # Callbacks

  # Relationships
  has_many :agents, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :phrases, dependent: :destroy

  has_one :admin, dependent: :destroy

  has_many :customers, through: :chats
  
  accepts_nested_attributes_for :admin

  # Validations
  validates_presence_of :biz_name, :biz_url, :existing_biz_url
  validates_time :end_hour, :after => :start_hour
   
    
  # Scopes
  
  # Other Methods

  
end
