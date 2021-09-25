module OrdersHelper
    def self.send_mail(email,order_id)
        OrderMailer.order_creation(order_id).deliver
    end
end
