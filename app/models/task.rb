# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  enum status: { to_do: 0, in_development: 1, done: 2, cancelled: 3 }

  scope :filter_by_status, ->(status_params) {
    where("status = :status and title = :title", { status: statuses[status_params], title: "%#{title}%" })
  }
end
