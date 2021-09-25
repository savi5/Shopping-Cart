class AddImageUrlToProductEntity < ActiveRecord::Migration
  def change
    add_column :product_entity, :image_url, :string
    add_column :cart_items, :product_image_url, :string
    add_column :order_item, :product_image_url, :string

  end
end
