class AddCostToCounty < ActiveRecord::Migration
  def change
    add_column :counties, :avg_annual_cost, :float
  end
end
