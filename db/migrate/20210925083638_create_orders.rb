class CreateOrders < ActiveRecord::Migration
  def change
    create_table :order do |t|
      t.references :customer_entity
      t.references :cart
      t.float :grand_total
      t.string :currency
      t.string :status
      t.timestamps null: false
    end
  end
end
