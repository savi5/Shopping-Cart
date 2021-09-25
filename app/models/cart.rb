class Cart < ActiveRecord::Base
include CartsHelper
    self.table_name = 'cart'
    has_many :cart_items
    
    def self.create_new_cart params 
        begin
            user_id = CustomerEntity.find_by_id(params[:user_id]).try{id} if params[:user_id].present?;
            product = ProductEntity.find_by_sku(params[:sku])
            cart = Cart.create!(items_count:1,grand_total: product.base_price,currency:params[:currency],customer_entity_id:user_id);
            cart.cart_items.create!(sku:product.sku,base_price: product.base_price,name:product.name, description:product.description,item_qty:1,product_image_url:product.image_url);
            return cart;
        rescue 
         return false;
        end
    end

    def get_cart_details
        begin
        res = {};
        res[:cart_id] = self.id;
        cart_items = self.cart_items;
        res[:items_count] = cart_items.count;
        res[:user_id] = self.customer_entity_id;
        res[:grand_total] = self.grand_total;
        res[:currency] = self.currency;
        res[:item_details] = [];
        for item in cart_items 
            item_res = {};
            item_res[:sku] = item.sku;
            item_res[:base_price] = item.base_price;
            item_res[:name] = item.name;
            item_res[:description] = item.description;
            item_res[:item_qty] = item.item_qty;
            item_res[:product_image_url] = item.product_image_url;
            res[:item_details] << item_res;
        end
        return res;
        rescue
            return false;
        end
    end

    def add_item(params)
        begin
            product = ProductEntity.find_by_sku(params[:sku])
            cart_item = self.cart_items.where(sku: params[:sku]).first;
                if(cart_item)
                item_qty = cart_item.item_qty + 1;
                cart_item.update!(item_qty:item_qty);
                else
                self.cart_items.create!(sku:product.sku,base_price: product.base_price,name:product.name,description:product.description,item_qty:1,product_image_url:product.image_url);
                end
            self.revise_prices;
            return true;
        rescue => e
            raise e
            return false;
        end
    end

    def delete_item(sku)
        begin
            self.cart_items.where(sku: sku).destroy_all;
            self.revise_prices;
            return true;
        rescue => e
            raise e;
            return false;
        end
    end

    def revise_prices
        grand_total = 0;
        cart_items = self.cart_items;
        for item in cart_items
            grand_total = grand_total + (item.base_price * item.item_qty)
        end
        self.update!({grand_total: grand_total});
    end

    
end
