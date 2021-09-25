class Order < ActiveRecord::Base
    include OrdersHelper

    self.table_name = 'order'
    has_many :order_item
    has_many :order_item_qty ,through: :order_item

    def self.associate_cart_to_user params
        user = CustomerEntity.find_by_email(params[:email]);
        cart = Cart.find_by_id(params[:cart_id]);
        if(user)
            cart.update!(customer_entity_id:user.id);
        else
            user = CustomerEntity.create!(email:params[:email],password:params[:password],name:params[:name]);
            cart.update!(customer_entity_id:user.id)
        end
        user
    end


    def self.create_order params
        begin
        cart = Cart.find_by_id(params[:cart_id]);
        cart_items = cart.cart_items;
        order = Order.create!(customer_entity_id:params[:user_id],
        cart_id:params[:cart_id],
        grand_total: cart.grand_total,
        currency: cart.currency,
        status: 'processing'
        )
        for cart_item in cart_items
        item = order.order_item.create!(
            order_id: order.id,
            product_entity_id: cart_item.product_entity_id,
            sku: cart_item.sku,
            name: cart_item.name,
            description: cart_item.description,
            product_image_url: cart_item.product_image_url,
            base_price: cart_item.base_price
        )
        for item_qty in 1..cart_item.item_qty do
            item.order_item_qty.create!({
                order_item_id: item.id,
                item_status: 'created',
                final_price: cart_item.base_price
            })
        end
        end
        #OrdersHelper.send_mail(params[:email],order.id);
        order.update!(status:'completed');
        order
        rescue => e
            raise e;
            return false;
        end
    end

    def self.get_order_details order_id
        begin
            res = {};
            order = Order.find_by_id(order_id);
            res[:order_id] = order.id;
            order_items = order.order_item;
            res[:user_id] = order.customer_entity_id;
            res[:grand_total] = order.grand_total;
            res[:currency] = order.currency;
            res[:status] = order.status
            res[:order_item_details] = [];
            for item in order_items 
                item_res = {};
                item_res[:item_id] = item.id;
                item_res[:sku] = item.sku;
                item_res[:item_name] = item.name;
                item_res[:description] = item.description;
                item_res[:base_price] = item.base_price;
                item_res[:product_image_url] = item.product_image_url;
                item_res[:item_qty_details] = [];
                item_qty_details = item.order_item_qty;

                for item_qty in item_qty_details
                    item_qty_res = {};
                    item_qty_res[:item_qty_id] = item_qty.id;
                    item_qty_res[:item_status] = item_qty.item_status;
                    item_qty_res[:final_price] = item_qty.final_price;
                    item_qty_res[:barcode] = item_qty.barcode;      
                    item_res[:item_qty_details] << item_qty_res;              
                end
                res[:order_item_details] << item_res;
            end
            return res;
            rescue => e
                raise e;
                return false;
            end
    end

    def self.get_details_date(start_date,end_date)

        orders = Order.where("created_at >= DATE(?) and created_at <= DATE(?)",start_date,end_date);
        res = {}
        res[:price_total] = 0;
        res[:order_details] = []
        for order in orders
            order = Order.get_order_details(order.id)
            res[:price_total]+= order[:grand_total];
            res[:order_details] << order;
        end
        res
    end

   
end
