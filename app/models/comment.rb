# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def get_user(comment)
    @user = User.find(comment.user_id)['email']
  end
end
