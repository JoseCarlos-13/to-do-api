# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |m| "MyString#{m}" }
  end
end
