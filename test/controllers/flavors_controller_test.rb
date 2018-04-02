require 'test_helper'

class FlavorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flavor = flavors(:one)
  end

  test "should get index" do
    get flavors_url
    assert_response :success
  end

  test "should get new" do
    get new_flavor_url
    assert_response :success
  end

  test "should create flavor" do
    assert_difference('Flavor.count') do
      post flavors_url, params: { flavor: { flavorImgURL: @flavor.flavorImgURL, name: @flavor.name } }
    end

    assert_redirected_to flavor_url(Flavor.last)
  end

  test "should show flavor" do
    get flavor_url(@flavor)
    assert_response :success
  end

  test "should get edit" do
    get edit_flavor_url(@flavor)
    assert_response :success
  end

  test "should update flavor" do
    patch flavor_url(@flavor), params: { flavor: { flavorImgURL: @flavor.flavorImgURL, name: @flavor.name } }
    assert_redirected_to flavor_url(@flavor)
  end

  test "should destroy flavor" do
    assert_difference('Flavor.count', -1) do
      delete flavor_url(@flavor)
    end

    assert_redirected_to flavors_url
  end
end
