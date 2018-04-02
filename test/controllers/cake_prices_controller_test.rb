require 'test_helper'

class CakePricesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cake_price = cake_prices(:one)
  end

  test "should get index" do
    get cake_prices_url
    assert_response :success
  end

  test "should get new" do
    get new_cake_price_url
    assert_response :success
  end

  test "should create cake_price" do
    assert_difference('CakePrice.count') do
      post cake_prices_url, params: { cake_price: { cake_id: @cake_price.cake_id, price: @cake_price.price, size: @cake_price.size } }
    end

    assert_redirected_to cake_price_url(CakePrice.last)
  end

  test "should show cake_price" do
    get cake_price_url(@cake_price)
    assert_response :success
  end

  test "should get edit" do
    get edit_cake_price_url(@cake_price)
    assert_response :success
  end

  test "should update cake_price" do
    patch cake_price_url(@cake_price), params: { cake_price: { cake_id: @cake_price.cake_id, price: @cake_price.price, size: @cake_price.size } }
    assert_redirected_to cake_price_url(@cake_price)
  end

  test "should destroy cake_price" do
    assert_difference('CakePrice.count', -1) do
      delete cake_price_url(@cake_price)
    end

    assert_redirected_to cake_prices_url
  end
end
