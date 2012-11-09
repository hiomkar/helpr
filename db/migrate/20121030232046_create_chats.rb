class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :business_id
      t.integer :customer_id
      t.text :keywords
      t.text :chat
      t.text :screenshots
      t.date :date_of_chat
      t.string :channel

      t.timestamps
    end
  end
end
