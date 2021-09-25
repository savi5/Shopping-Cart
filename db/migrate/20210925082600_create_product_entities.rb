class CreateProductEntities < ActiveRecord::Migration
  def change
    create_table :product_entity do |t|
      t.string :sku , :limit => 20
      t.string :name
      t.text :description
      t.float :base_price
      t.timestamps null: false
    end
  end
end
