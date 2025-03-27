# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end

  context 'enums' do
    it { is_expected.to define_enum_for(:status) }
    it { is_expected.to define_enum_for(:status).with_values(active: 0, inactive: 1) }
  end
end
