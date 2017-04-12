class Story < ApplicationRecord
  validates :url_link, format: { with: /\A(https|http)/ }
  has_many :comments

  belongs_to :created_by, class_name: "User"

  include ImageUploader[:image]

  def can_this_user_edit?(user)
    created_by == user
  end

  def can_this_user_destroy?(user)
    created_by == user
  end
end
