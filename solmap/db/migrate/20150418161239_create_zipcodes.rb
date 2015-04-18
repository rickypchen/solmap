class CreateZipcodes < ActiveRecord::Migration
  def change
    create_table :zipcodes do |t|
      t.string :code
      t.string :county_name
      t.string :city_name
      t.integer :state_id, index: true

      t.timestamps null: false
    end
  end
end
