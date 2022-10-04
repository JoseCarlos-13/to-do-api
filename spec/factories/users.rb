# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "MyString#{n}" }
  end
end
