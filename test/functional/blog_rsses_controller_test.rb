# -*- encoding : utf-8 -*-
require 'test_helper'

class BlogRssesControllerTest < ActionController::TestCase
  setup do
    @blog_rss = blog_rsses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blog_rsses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blog_rss" do
    assert_difference('BlogRss.count') do
      post :create, :blog_rss => @blog_rss.attributes
    end

    assert_redirected_to blog_rss_path(assigns(:blog_rss))
  end

  test "should show blog_rss" do
    get :show, :id => @blog_rss.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @blog_rss.to_param
    assert_response :success
  end

  test "should update blog_rss" do
    put :update, :id => @blog_rss.to_param, :blog_rss => @blog_rss.attributes
    assert_redirected_to blog_rss_path(assigns(:blog_rss))
  end

  test "should destroy blog_rss" do
    assert_difference('BlogRss.count', -1) do
      delete :destroy, :id => @blog_rss.to_param
    end

    assert_redirected_to blog_rsses_path
  end
end
