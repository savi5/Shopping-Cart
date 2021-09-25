module API::V1
    class Product < Grape::API
    helpers ProductHelper
    resource :product do 
        desc "Listing products with offset(5) used for pagination"
        params do 
            requires :page, type: Integer, desc: 'Offset number'
            requires :limit, type: Integer, default: 5 ,desc: 'Products per page'
        end
        get '/listing/' do
            res = ProductEntity.getProducts(params[:page],params[:limit]);
            if res.blank?
                status(404)
                status = { code: false, message: 'Something went wrong' }
            else
                status(201)
                status = { code: true , message:'Products fetched successfully',listing: res }
            end
            status
        end
    end
end
end