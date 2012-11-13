class ChangeAssociationIds < ActiveRecord::Migration
  def change
    add_column :admins, :business_id, :integer
    remove_column :businesses, :admin_id
  end

end
