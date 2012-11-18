class AddAttachmentSharedFileToMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.has_attached_file :shared_file
    end
  end

  def self.down
    drop_attached_file :messages, :shared_file
  end
end
