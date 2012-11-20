class Customer < ActiveRecord::Base
  has_many :chats

  has_many :businesses, through: :chats
  
  attr_accessible :first_name, :last_name, :phone, :email, :chats_attributes

end