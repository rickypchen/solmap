class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string :name
      t.integer :state_id, index: true
      t.float :irradiance_dni
      t.float :irradiance_ghi
      t.float :irradiance_lat_tilt

      t.timestamps null: false
    end
  end
end
