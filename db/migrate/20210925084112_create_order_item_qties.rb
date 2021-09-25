class CreateOrderItemQties < ActiveRecord::Migration
  def change
    create_table :order_item_qty do |t|
      t.references :order_item
      t.string :item_status
      t.float :final_price
      t.string :barcode
      t.timestamps null: false
    end
  end
end
