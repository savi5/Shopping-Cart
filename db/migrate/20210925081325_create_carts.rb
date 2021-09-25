class CreateCarts < ActiveRecord::Migration
  def change
    create_table :cart do |t|
      t.references :customer_entity
      t.float :grand_total
      t.string :currency
      t.integer :items_count
      t.timestamps null: false
    end
  end
end
