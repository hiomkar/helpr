class CreateChatUsers < ActiveRecord::Migration
  def change
    create_table :chat_users do |t|
      t.string :first_name
      t.timestamps
    end
  end
end
