class RemoveUnusedFields < ActiveRecord::Migration
  def change
    remove_column :businesses, :existing_biz_url
    remove_column :chats, :keywords, :chat, :date_of_chat, :screenshots
  end
end
