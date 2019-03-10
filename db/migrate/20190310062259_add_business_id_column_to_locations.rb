class AddBusinessIdColumnToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :business_id, :integer
  end
end
