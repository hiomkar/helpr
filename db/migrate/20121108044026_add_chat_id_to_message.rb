class AddChatIdToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :chat_id, :integer
    add_column :messages, :user_id, :integer
    add_column :messages, :username, :string
    add_column :messages, :message, :string
  end
end
