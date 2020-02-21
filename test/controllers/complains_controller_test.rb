require 'test_helper'

class ComplainsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @complain = complains(:one)
  end

  test "should get index" do
    get complains_url, as: :json
    assert_response :success
  end

  test "should create complain" do
    assert_difference('Complain.count') do
      post complains_url, params: { complain: { company: @complain.company, description: @complain.description, locale: @complain.locale, title: @complain.title } }, as: :json
    end

    assert_response 201
  end

  test "should show complain" do
    get complain_url(@complain), as: :json
    assert_response :success
  end

  test "should update complain" do
    patch complain_url(@complain), params: { complain: { company: @complain.company, description: @complain.description, locale: @complain.locale, title: @complain.title } }, as: :json
    assert_response 200
  end

  test "should destroy complain" do
    assert_difference('Complain.count', -1) do
      delete complain_url(@complain), as: :json
    end

    assert_response 204
  end
end
