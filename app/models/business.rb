class Business < ActiveRecord::Base
  
  # removed admin_id
  attr_accessible :biz_name, :biz_url, :end_hour, :start_hour 
  # Callbacks

  # Relationships
  has_many :agents, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :phrases, dependent: :destroy

  has_one :admin, dependent: :destroy

  has_many :customers, through: :chats
  
  accepts_nested_attributes_for :admin

  # Validations
  validates_presence_of :biz_name, :biz_url
  validates_time :end_hour, :after => :start_hour, :after_message => 'Start hour must be before end hour.'
  validates_uniqueness_of :biz_url
   
    
  # Scopes
  
  # Other Methods

  
end
