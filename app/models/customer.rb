class Customer < ActiveRecord::Base
  has_many :chats, dependent: :destroy

  has_many :businesses, through: :chats

end