class OrderItemQty < ActiveRecord::Base
    self.table_name = 'order_item_qty'
    belongs_to :order_item
end
