class DropTableCartsItems < ActiveRecord::Migration[6.0]
  def change
    drop_table :carts_items
  end
end
