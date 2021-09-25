module API::V1
    class Base < Grape::API
      version 'v1', using: :path
      format :json
      mount API::V1::Carts
      mount API::V1::Product
      mount API::V1::Orders
    end
end