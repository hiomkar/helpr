class Business < ActiveRecord::Base
  attr_accessible :admin_id, :biz_name, :biz_url, :end_hour, :existing_biz_url, :start_hour

  has_many :agents, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :phrases, dependent: :destroy

  has_one :admin, dependent: :destroy

  has_many :customers, through: :chats

end
