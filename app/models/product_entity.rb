class ProductEntity < ActiveRecord::Base
    self.table_name = 'product_entity'
    def self.getProducts page,limit
        offset = (page - 1) * limit + 1;
        res = []
        products = ProductEntity.where("id >= ?",offset).limit(limit);
        for item in products 
            product = {}
            product[:name] = item.name;
            product[:sku] = item.sku;
            product[:description] = item.description;
            product[:price] = item.base_price;
            product[:image_url] = item.image_url;
            res << product
        end
        res;
    end
end
