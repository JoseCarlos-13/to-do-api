# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  enum status: { to_do: 0, in_development: 1, done: 2, cancelled: 3 }

  scope :filter_by_status, ->(status) { where(status: statuses[status]) }
  scope :filter_by_title, ->(title) { where('title like ?', "%#{title}%") }
  scope :filter_by_user_name, ->(user_name) { self.joins(:user).where("name like ?", "%#{user_name}%") }
end
