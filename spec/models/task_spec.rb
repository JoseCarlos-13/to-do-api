# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }

  it { is_expected.to define_enum_for(:status) }
  it { is_expected.to define_enum_for(:status).with_values(to_do: 0, in_development: 1, done: 2) }
end
