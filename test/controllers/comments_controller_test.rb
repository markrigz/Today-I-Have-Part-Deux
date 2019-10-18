# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
  end

  test 'should get index' do
    get post_comments_url
    assert_response :success
  end

  test 'should get new' do
    get post_new_comment_url
    assert_response :success
  end

  test 'should create comment' do
    assert_difference('Comment.count') do
      post post_comments_url, params: { comment: { comment: @comment.comment, post_id: @comment.post_id } }
    end

    assert_redirected_to comment_url(Comment.last)
  end

  test 'should show comment' do
    get post_comment_url(@comment)
    assert_response :success
  end

  test 'should destroy comment' do
    assert_difference('Comment.count', -1) do
      delete post_comment_url(@comment)
    end

    assert_redirected_to comments_url
  end
end
