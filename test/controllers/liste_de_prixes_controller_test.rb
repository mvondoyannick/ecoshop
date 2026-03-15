require "test_helper"

class ListeDePrixesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @liste_de_prix = liste_de_prixes(:one)
  end

  test "should get index" do
    get liste_de_prixes_url
    assert_response :success
  end

  test "should get new" do
    get new_liste_de_prix_url
    assert_response :success
  end

  test "should create liste_de_prix" do
    assert_difference("ListeDePrix.count") do
      post liste_de_prixes_url, params: { liste_de_prix: { supermarche_id: @liste_de_prix.supermarche_id } }
    end

    assert_redirected_to liste_de_prix_url(ListeDePrix.last)
  end

  test "should show liste_de_prix" do
    get liste_de_prix_url(@liste_de_prix)
    assert_response :success
  end

  test "should get edit" do
    get edit_liste_de_prix_url(@liste_de_prix)
    assert_response :success
  end

  test "should update liste_de_prix" do
    patch liste_de_prix_url(@liste_de_prix), params: { liste_de_prix: { supermarche_id: @liste_de_prix.supermarche_id } }
    assert_redirected_to liste_de_prix_url(@liste_de_prix)
  end

  test "should destroy liste_de_prix" do
    assert_difference("ListeDePrix.count", -1) do
      delete liste_de_prix_url(@liste_de_prix)
    end

    assert_redirected_to liste_de_prixes_url
  end
end
