class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.integer :business_id
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
