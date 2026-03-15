require "test_helper"

class SupermarchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supermarch = supermarches(:one)
  end

  test "should get index" do
    get supermarches_url
    assert_response :success
  end

  test "should get new" do
    get new_supermarch_url
    assert_response :success
  end

  test "should create supermarch" do
    assert_difference("Supermarche.count") do
      post supermarches_url, params: { supermarch: { code: @supermarch.code, email: @supermarch.email, latitude: @supermarch.latitude, lieu_dit: @supermarch.lieu_dit, logo: @supermarch.logo, longitude: @supermarch.longitude, name: @supermarch.name, phone: @supermarch.phone, quartier: @supermarch.quartier, ville_id: @supermarch.ville_id } }
    end

    assert_redirected_to supermarch_url(Supermarche.last)
  end

  test "should show supermarch" do
    get supermarch_url(@supermarch)
    assert_response :success
  end

  test "should get edit" do
    get edit_supermarch_url(@supermarch)
    assert_response :success
  end

  test "should update supermarch" do
    patch supermarch_url(@supermarch), params: { supermarch: { code: @supermarch.code, email: @supermarch.email, latitude: @supermarch.latitude, lieu_dit: @supermarch.lieu_dit, logo: @supermarch.logo, longitude: @supermarch.longitude, name: @supermarch.name, phone: @supermarch.phone, quartier: @supermarch.quartier, ville_id: @supermarch.ville_id } }
    assert_redirected_to supermarch_url(@supermarch)
  end

  test "should destroy supermarch" do
    assert_difference("Supermarche.count", -1) do
      delete supermarch_url(@supermarch)
    end

    assert_redirected_to supermarches_url
  end
end
