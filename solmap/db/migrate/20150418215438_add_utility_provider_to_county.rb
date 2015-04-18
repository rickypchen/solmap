class AddUtilityProviderToCounty < ActiveRecord::Migration
  def change
    add_column :counties, :utility_provider, :string
  end
end
