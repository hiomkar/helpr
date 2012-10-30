class Business < ActiveRecord::Base
  attr_accessible :admin_id, :biz_name, :biz_url, :end_hour, :existing_biz_url, :start_hour
end
