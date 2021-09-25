class OrderItem < ActiveRecord::Base
    self.table_name = 'order_item'
    has_many :order_item_qty
end
