class AlterZipcodeTable < ActiveRecord::Migration
  def change
  	remove_column :zipcodes, :county_name
  	remove_column :zipcodes, :state_id
  	add_column :zipcodes, :county_id, :integer, index: true
  end
end
