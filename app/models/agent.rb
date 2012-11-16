class Agent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :business_id, :first_name, :last_name
  belongs_to :business
  
  
  # Scopes
  scope :alphabetical, order('last_name, first_name')
  scope :for_business, lambda {|business_id| where("business_id = ?", business_id) }
  
end
