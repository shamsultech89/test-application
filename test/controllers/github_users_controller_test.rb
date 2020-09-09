require 'test_helper'

class GithubUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @github_user = github_users(:one)
  end

  test "should get index" do
    get github_users_url
    assert_response :success
  end

  test "should get new" do
    get new_github_user_url
    assert_response :success
  end

  test "should create github_user" do
    assert_difference('GithubUser.count') do
      post github_users_url, params: { github_user: { avatar_url: @github_user.avatar_url, github_id: @github_user.github_id, name: @github_user.name } }
    end

    assert_redirected_to github_user_url(GithubUser.last)
  end

  test "should show github_user" do
    get github_user_url(@github_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_github_user_url(@github_user)
    assert_response :success
  end

  test "should update github_user" do
    patch github_user_url(@github_user), params: { github_user: { avatar_url: @github_user.avatar_url, github_id: @github_user.github_id, name: @github_user.name } }
    assert_redirected_to github_user_url(@github_user)
  end

  test "should destroy github_user" do
    assert_difference('GithubUser.count', -1) do
      delete github_user_url(@github_user)
    end

    assert_redirected_to github_users_url
  end
end
