require "application_system_test_case"

class SocietesTest < ApplicationSystemTestCase
  setup do
    @societe = societes(:one)
  end

  test "visiting the index" do
    visit societes_url
    assert_selector "h1", text: "Societes"
  end

  test "should create societe" do
    visit societes_url
    click_on "New societe"

    fill_in "Email", with: @societe.email
    fill_in "Name", with: @societe.name
    fill_in "Phone", with: @societe.phone
    fill_in "Ville", with: @societe.ville_id
    click_on "Create Societe"

    assert_text "Societe was successfully created"
    click_on "Back"
  end

  test "should update Societe" do
    visit societe_url(@societe)
    click_on "Edit this societe", match: :first

    fill_in "Email", with: @societe.email
    fill_in "Name", with: @societe.name
    fill_in "Phone", with: @societe.phone
    fill_in "Ville", with: @societe.ville_id
    click_on "Update Societe"

    assert_text "Societe was successfully updated"
    click_on "Back"
  end

  test "should destroy Societe" do
    visit societe_url(@societe)
    accept_confirm { click_on "Destroy this societe", match: :first }

    assert_text "Societe was successfully destroyed"
  end
end
