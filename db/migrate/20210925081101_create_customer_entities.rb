class CreateCustomerEntities < ActiveRecord::Migration
  def change
    create_table :customer_entity do |t|
      t.string :email , :limit=>100
      t.string :name, :limit=>100
      t.string :password
      t.timestamps null: false
    end
  end
end

