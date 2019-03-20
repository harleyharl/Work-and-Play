class AddUidToBusiness < ActiveRecord::Migration[5.2]
  def change
    add_column :businesses, :uid, :integer
  end
end
