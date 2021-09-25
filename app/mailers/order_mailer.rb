class OrderMailer < ActionMailer::Base
    default from: "test@gmail.com"
    layout 'mailer'
    def order_creation(order_id)
        @order = Order.find_by_id(order_id)
        @customer = CustomerEntity.find_by_id(@order.customer_entity_id)
        subject = 'Your order is placed!';
        message = "Your order is placed successfully. Track your order details on http://tracker//#{@order.id}"
        mail(from:'test@gmail.com' ,to: @customer.email, subject: subject,message:message )
    end
end
