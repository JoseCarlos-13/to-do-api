# frozen_string_literal: true
FactoryBot.define do
  factory :task do
    status { 0 }
    sequence(:title) { |n| "MyString#{n}" }
    sequence(:description) { |n| "MyString#{n}" }
  end
end
