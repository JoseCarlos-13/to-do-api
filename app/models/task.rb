# frozen_string_literal: true
class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  enum status: { in_development: 0, done: 1 }
end
