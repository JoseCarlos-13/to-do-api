# frozen_string_literal: true

require 'rails_helper'
require 'support/request_helper_spec'

RSpec.describe 'Tasks', type: :request do
  describe 'GET#index' do
    context 'when have much task created' do
      let(:tasks) { create_list(:task, 3) }

      before do
        tasks

        get '/tasks'
      end

      it 'return response status code and the tasks created' do
        expect(response).to have_http_status(:ok)
        expect(json_body[0]).to have_key(:id)
        expect(json_body[0]).to have_key(:title)
        expect(json_body[0]).to have_key(:status)
      end
    end
  end
end
