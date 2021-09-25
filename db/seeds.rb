# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CustomerEntity.create(name: 'Test',email: "test@gmail.com");
CustomerEntity.create(name: 'admin',email: "admin@gmail.com", password:"test123");


ProductEntity.create(sku:"SKDIKATBAG7483AW",name:"Yellow Cotton Straight Suit Set",description:"A gorgeous suit set from Biba casual wear collection. Do Not Bleach, Cold Iron.",base_price:2999,image_url:"http://image.jpg");
ProductEntity.create(sku:"FTWWEONKLP000060",name:"Yellow Formal Kolhapur Slipper",description:"Yellow Formal Kolhapur Slipper",base_price:799,image_url:"http://image2.jpg");
ProductEntity.create(sku:"BR00EONKLP000060",name:"Black Viscose Slit Dress",description:"Black Viscose dress",base_price:1799,image_url:"http://image3.jpg");
ProductEntity.create(sku:"TFFEONKLP000060",name:"Off White Front Open Art Silk Dress",description:"YelOff White Front Open Art Silk Dress",base_price:1999,image_url:"http://image4.jpg");
ProductEntity.create(sku:"BFFYEONKLP000060",name:"Off White Cotton Tiered Dress",description:"Off White Cotton Tiered Dress",base_price:2799,image_url:"http://image5.jpg");
ProductEntity.create(sku:"KT09EONKLP000060",name:"Maroon Cotton Tiered Dress",description:"Maroon Cotton Tiered Dress",base_price:799,image_url:"http://image6.jpg");
ProductEntity.create(sku:"RE02EONKLP000060",name:"Red Cotton Fusion Dress",description:"Red Cotton Fusion Dress",base_price:3799,image_url:"http://image7.jpg");
ProductEntity.create(sku:"FTWWEONKLP000060",name:"Yellow Formal Kolhapur Slipper",description:"Yellow Formal Kolhapur Slipper",base_price:799,image_url:"http://image8.jpg");


Cart.create(customer_entity_id:1,grand_total:799);
CartItem.create(cart_id:1,product_entity_id:5);


Order.create(customer_entity_id:1,cart_id:1,grand_total:799);
OrderItem.create(order_id:1);
OrderItemQty.create(order_item_id:1);