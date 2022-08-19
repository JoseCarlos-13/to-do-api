require 'rails_helper'

RSpec.describe Task, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }

  it { is_expected.to define_enum_for(:status) }
  it { is_expected.to define_enum_for(:status).with_values(in_development: 0, done: 1) }
end
