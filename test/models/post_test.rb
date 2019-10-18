# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  fixtures :posts

  # Test empty post attributes
  test 'post attributes must not be empty' do
    post = posts(:correct_post)
    post.user = User.first
    post.title = 'Horse' # To get past the 'title already exists' check
    assert post.valid?, "#{post.errors.full_messages} ...text"
  end

  # Test invalid attribute lengths
  test 'post body must be at least 10 characters' do
    post = posts(:post_with_short_body)

    assert post.invalid?
    assert post.errors[:body].any?
    # assert post.errors[:tag].any?
  end
end
