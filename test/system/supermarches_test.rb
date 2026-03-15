require "application_system_test_case"

class SupermarchesTest < ApplicationSystemTestCase
  setup do
    @supermarch = supermarches(:one)
  end

  test "visiting the index" do
    visit supermarches_url
    assert_selector "h1", text: "Supermarches"
  end

  test "should create supermarche" do
    visit supermarches_url
    click_on "New supermarche"

    fill_in "Code", with: @supermarch.code
    fill_in "Email", with: @supermarch.email
    fill_in "Latitude", with: @supermarch.latitude
    fill_in "Lieu dit", with: @supermarch.lieu_dit
    fill_in "Logo", with: @supermarch.logo
    fill_in "Longitude", with: @supermarch.longitude
    fill_in "Name", with: @supermarch.name
    fill_in "Phone", with: @supermarch.phone
    fill_in "Quartier", with: @supermarch.quartier
    fill_in "Ville", with: @supermarch.ville_id
    click_on "Create Supermarche"

    assert_text "Supermarche was successfully created"
    click_on "Back"
  end

  test "should update Supermarche" do
    visit supermarch_url(@supermarch)
    click_on "Edit this supermarche", match: :first

    fill_in "Code", with: @supermarch.code
    fill_in "Email", with: @supermarch.email
    fill_in "Latitude", with: @supermarch.latitude
    fill_in "Lieu dit", with: @supermarch.lieu_dit
    fill_in "Logo", with: @supermarch.logo
    fill_in "Longitude", with: @supermarch.longitude
    fill_in "Name", with: @supermarch.name
    fill_in "Phone", with: @supermarch.phone
    fill_in "Quartier", with: @supermarch.quartier
    fill_in "Ville", with: @supermarch.ville_id
    click_on "Update Supermarche"

    assert_text "Supermarche was successfully updated"
    click_on "Back"
  end

  test "should destroy Supermarche" do
    visit supermarch_url(@supermarch)
    accept_confirm { click_on "Destroy this supermarche", match: :first }

    assert_text "Supermarche was successfully destroyed"
  end
end
