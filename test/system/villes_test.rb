require "application_system_test_case"

class VillesTest < ApplicationSystemTestCase
  setup do
    @ville = villes(:one)
  end

  test "visiting the index" do
    visit villes_url
    assert_selector "h1", text: "Villes"
  end

  test "should create ville" do
    visit villes_url
    click_on "New ville"

    fill_in "Code", with: @ville.code
    fill_in "Name", with: @ville.name
    click_on "Create Ville"

    assert_text "Ville was successfully created"
    click_on "Back"
  end

  test "should update Ville" do
    visit ville_url(@ville)
    click_on "Edit this ville", match: :first

    fill_in "Code", with: @ville.code
    fill_in "Name", with: @ville.name
    click_on "Update Ville"

    assert_text "Ville was successfully updated"
    click_on "Back"
  end

  test "should destroy Ville" do
    visit ville_url(@ville)
    click_on "Destroy this ville", match: :first

    assert_text "Ville was successfully destroyed"
  end
end
