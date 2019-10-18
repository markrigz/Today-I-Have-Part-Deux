# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 10 }
  validate :unique_to_day

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def get_username(email)
    email.split('@', 0)[0]
  end

  private

  def unique_to_day
    title = self[:title]

    unless Post.where('title = ? AND created_at > ?', title, Time.now.beginning_of_day).empty?
      errors.add(:title, 'already posted today')
    end
  end
end
