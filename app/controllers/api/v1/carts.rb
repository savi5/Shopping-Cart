module API::V1
    class Carts < Grape::API
        resource :cart do 
            desc 'The cart api will get cart details'
    
            params do
              requires :cart_id, type: Integer,desc: 'cartid'
              optional :user_id, type: Integer, default: 0, desc: 'user id of customer if available'
           end
      
            get "/:card_id" do
              cart = Cart.find_by_id(params[:cart_id]);
              if cart.blank?
                status(404)
                status = { code: false, message: 'Cart not found' }
              else
                status(201)
                status = { code: true , message:'Cart details fetched successfully',cart_details: cart.get_cart_details }
              end
              status
            end

            desc 'The cart api will create/add item the cart with or without users'
    
            params do
              requires :sku,type: String, desc: 'sku of product';
              optional :cart_id, type: Integer, desc: 'cart id of existing cart'
              optional :user_id, type: Integer, default: 0, desc: 'user id of customer if available'
              optional :currency, type: String, default: 'en_IN', desc: 'Currency of cart'
            end
      
            post  do
             if params['cart_id'].present?
              cart = Cart.find_by_id(params[:cart_id]);
              if cart.blank?
                status(404)
                status = { code: false, message: 'Cart not found' }
              else
                 res = cart.add_item(params);
                 if(res)
                 status(201)
                 status = { code: true , message:'Item added successfully',cart_details: cart.get_cart_details }
                 else
                  status(404)
                  status = { code: false, message: 'Unable to add item' }
                 end
              end     
            else
                cart = Cart.create_new_cart(params);
                if(cart.blank?)
                  status(404)
                  status = { code: false, message: 'Unable to create cart' }
                else
                status(201)
                status = { code: true , message:'Cart created successfully',cart_details: cart.get_cart_details }
                end
            end
             status
            end

            
            desc 'The cart api will delete item in cart'
    
            params do
              requires :sku,type: String, desc: 'sku of product';
              requires :cart_id, type: Integer, desc: 'cart id of existing cart'
            end
      
            delete '/:cart_id/:sku'  do
              cart = Cart.find_by_id(params[:cart_id]);
              if cart.blank?
                status(404)
                status = { code: false, message: 'Cart not found' }
              else
                 res = cart.delete_item(params[:sku]);
                 if(res)
                 status(201)
                 status = { code: true , message:'Item delete successfully',cart_details: cart.get_cart_details }
                 else
                  status(404)
                  status = { code: false, message: 'Unable to delete item' }
                 end
              end 
              status
            end

        end
    end
end