# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  enum status: { to_do: 0, in_development: 1, done: 2, cancelled: 3 }

  scope :filter_by_multiple_params, lambda { |status, title, user_name|
    joins(:user).where(
      'status like :status OR title like :title OR name like :name',
      status: statuses(status), title: "%#{title}%", name: "%#{user_name}%"
    )
  }
end
