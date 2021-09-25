module API::V1
    class Orders < Grape::API
        resource :order do 
            desc 'The api will create order and send order creation email'
            params do 
                requires :cart_id,type: Integer, desc: 'cart_id'
                requires :payment_mode,type: String,default: 'COD',desc: 'Type of payment made'
                optional :email,type: String, desc: 'Email id of customer if guest user'
                optional :customer_name,type: String, desc: 'Email id of customer if guest user'
                optional :customer_password,type: String, desc: 'Email id of customer if guest user'
                optional :user_id, type: Integer,desc: 'user_id if customer is already loggedin'
            end
            post  do
                status = {code: true}
                if params['user_id'].present?
                    user = User.find_by_id(params[:user_id]);
                    if user.blank?
                      status(404)
                      status = { code: false, message: 'Invalid user_id' }
                    else
                        params[:email] = user.email
                    end
                else
                    user = Order.associate_cart_to_user(params);
                    params[:user_id] = user.id
                end   
                if(status[:code])
                    order = Order.create_order(params);
                    if(order)
                    status(201)
                    status = { code: true , message:'Order created successfully',order_details: Order.get_order_details(order.id) }
                    else
                    status(404)
                    status = { code: false, message: 'Something went wrong while creating order' }
                    end  
                end
                status
            end



            desc 'Get orders from given date range'
            params do 
                requires :start_date,type: Date, desc: 'Start date',coerce_with: Date.method(:iso8601)
                requires :end_date,type: Date,desc: 'End date',coerce_with: Date.method(:iso8601)
               end
            get '/order_details' do
                begin
                res = Order.get_details_date(params[:start_date],params[:end_date]);
                Rails.logger.info(res);
                if(res)
                    status(201)
                    status = { code: true , message:'Order details fetched successfully',order_details: res }
                else
                    status(404)
                    status = { code: false, message: 'Something went wrong while fetching details' }
                end  
                status
                rescue => e
                    status(500)
                    status = { code: false , message:'Something went wrong while fetching details',error:e.message ,trace:e.backtrace}
                    status
                end
              end
        end
    end
end