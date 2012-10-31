class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.integer :business_id
      t.text :phrase

      t.timestamps
    end
  end
end
