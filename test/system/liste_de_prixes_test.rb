require "application_system_test_case"

class ListeDePrixesTest < ApplicationSystemTestCase
  setup do
    @liste_de_prix = liste_de_prixes(:one)
  end

  test "visiting the index" do
    visit liste_de_prixes_url
    assert_selector "h1", text: "Liste de prixes"
  end

  test "should create liste de prix" do
    visit liste_de_prixes_url
    click_on "New liste de prix"

    fill_in "Supermarche", with: @liste_de_prix.supermarche_id
    click_on "Create Liste de prix"

    assert_text "Liste de prix was successfully created"
    click_on "Back"
  end

  test "should update Liste de prix" do
    visit liste_de_prix_url(@liste_de_prix)
    click_on "Edit this liste de prix", match: :first

    fill_in "Supermarche", with: @liste_de_prix.supermarche_id
    click_on "Update Liste de prix"

    assert_text "Liste de prix was successfully updated"
    click_on "Back"
  end

  test "should destroy Liste de prix" do
    visit liste_de_prix_url(@liste_de_prix)
    accept_confirm { click_on "Destroy this liste de prix", match: :first }

    assert_text "Liste de prix was successfully destroyed"
  end
end
