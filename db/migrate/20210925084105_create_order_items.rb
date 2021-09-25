class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_item do |t|
      t.references :order
      t.references :product_entity
      t.string :sku,:limit=>20
      t.string :name
      t.text :description
      t.float :base_price
      t.timestamps null: false
    end
  end
end
