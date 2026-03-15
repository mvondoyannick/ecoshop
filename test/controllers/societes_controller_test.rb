require "test_helper"

class SocietesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @societe = societes(:one)
  end

  test "should get index" do
    get societes_url
    assert_response :success
  end

  test "should get new" do
    get new_societe_url
    assert_response :success
  end

  test "should create societe" do
    assert_difference("Societe.count") do
      post societes_url, params: { societe: { email: @societe.email, name: @societe.name, phone: @societe.phone, ville_id: @societe.ville_id } }
    end

    assert_redirected_to societe_url(Societe.last)
  end

  test "should show societe" do
    get societe_url(@societe)
    assert_response :success
  end

  test "should get edit" do
    get edit_societe_url(@societe)
    assert_response :success
  end

  test "should update societe" do
    patch societe_url(@societe), params: { societe: { email: @societe.email, name: @societe.name, phone: @societe.phone, ville_id: @societe.ville_id } }
    assert_redirected_to societe_url(@societe)
  end

  test "should destroy societe" do
    assert_difference("Societe.count", -1) do
      delete societe_url(@societe)
    end

    assert_redirected_to societes_url
  end
end
