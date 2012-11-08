class AddChannelToChat < ActiveRecord::Migration
  def change
    add_column :chats, :channel, :string
    add_column :chats, :owner, :string
  end
end
