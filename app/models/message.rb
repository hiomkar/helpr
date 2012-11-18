class Message < ActiveRecord::Base

  attr_accessible :shared_file

  belongs_to :chat

  has_attached_file :shared_file,
                    :storage => :dropbox,
                    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",


end
