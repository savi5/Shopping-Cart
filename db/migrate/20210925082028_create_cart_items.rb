class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.references :cart
      t.references :product_entity
      t.string :sku , :limit => 20
      t.float :base_price
      t.text :description
      t.integer :item_qty
      t.timestamps null: false
    end
  end
end
