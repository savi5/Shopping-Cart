require "test_helper"
class API::V1::CartsTest < ActiveSupport::TestCase
    include Rack::Test::Methods
  
    def app
      Rails.application
    end
     test "POST /api/v1/cart?sku=RE02EONKLP000060" do
        post("/api/v1/cart?sku=RE02EONKLP000060")
        json_response = JSON.parse(last_response.body)
        assert_not(json_response[:code],true)
      end
      test "GET api/v1/cart/20?cart_id=20" do
        get("api/v1/cart/20?cart_id=20")
        json_response = JSON.parse(last_response.body)
        assert_not(json_response[:code],false)
      end
        test "GET api/v1/cart/298486374?cart_id=298486374" do
        get("api/v1/cart/298486374?cart_id=298486374")
        json_response = JSON.parse(last_response.body)
        assert_not(json_response[:code],true)
  end

end