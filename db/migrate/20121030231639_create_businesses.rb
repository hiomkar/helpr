class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.integer :admin_id
      t.string :biz_name
      t.string :biz_url
      t.string :existing_biz_url
      t.time :start_hour
      t.time :end_hour

      t.timestamps
    end
  end
end
