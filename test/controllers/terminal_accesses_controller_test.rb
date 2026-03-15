require "test_helper"

class TerminalAccessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @terminal_access = terminal_accesses(:one)
  end

  test "should get index" do
    get terminal_accesses_url
    assert_response :success
  end

  test "should get new" do
    get new_terminal_access_url
    assert_response :success
  end

  test "should create terminal_access" do
    assert_difference("TerminalAccess.count") do
      post terminal_accesses_url, params: { terminal_access: { blocked: @terminal_access.blocked, country: @terminal_access.country, ip_address: @terminal_access.ip_address, url: @terminal_access.url, user_agent: @terminal_access.user_agent } }
    end

    assert_redirected_to terminal_access_url(TerminalAccess.last)
  end

  test "should show terminal_access" do
    get terminal_access_url(@terminal_access)
    assert_response :success
  end

  test "should get edit" do
    get edit_terminal_access_url(@terminal_access)
    assert_response :success
  end

  test "should update terminal_access" do
    patch terminal_access_url(@terminal_access), params: { terminal_access: { blocked: @terminal_access.blocked, country: @terminal_access.country, ip_address: @terminal_access.ip_address, url: @terminal_access.url, user_agent: @terminal_access.user_agent } }
    assert_redirected_to terminal_access_url(@terminal_access)
  end

  test "should destroy terminal_access" do
    assert_difference("TerminalAccess.count", -1) do
      delete terminal_access_url(@terminal_access)
    end

    assert_redirected_to terminal_accesses_url
  end
end
