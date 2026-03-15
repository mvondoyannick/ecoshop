require "application_system_test_case"

class TerminalAccessesTest < ApplicationSystemTestCase
  setup do
    @terminal_access = terminal_accesses(:one)
  end

  test "visiting the index" do
    visit terminal_accesses_url
    assert_selector "h1", text: "Terminal accesses"
  end

  test "should create terminal access" do
    visit terminal_accesses_url
    click_on "New terminal access"

    check "Blocked" if @terminal_access.blocked
    fill_in "Country", with: @terminal_access.country
    fill_in "Ip address", with: @terminal_access.ip_address
    fill_in "Url", with: @terminal_access.url
    fill_in "User agent", with: @terminal_access.user_agent
    click_on "Create Terminal access"

    assert_text "Terminal access was successfully created"
    click_on "Back"
  end

  test "should update Terminal access" do
    visit terminal_access_url(@terminal_access)
    click_on "Edit this terminal access", match: :first

    check "Blocked" if @terminal_access.blocked
    fill_in "Country", with: @terminal_access.country
    fill_in "Ip address", with: @terminal_access.ip_address
    fill_in "Url", with: @terminal_access.url
    fill_in "User agent", with: @terminal_access.user_agent
    click_on "Update Terminal access"

    assert_text "Terminal access was successfully updated"
    click_on "Back"
  end

  test "should destroy Terminal access" do
    visit terminal_access_url(@terminal_access)
    accept_confirm { click_on "Destroy this terminal access", match: :first }

    assert_text "Terminal access was successfully destroyed"
  end
end
