# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'PUT#cancel_account' do
    let(:user) { create(:user) }
    let(:user_attributes) { attributes_for(:user, status: 'inactive') }

    context 'when the user not have any task' do
      before do
        user
        # put "users/#{user.id}/cancel_account", params: { user_attributes }
      end

      # it 'must return a user' do
      # end
    end
  end
end
