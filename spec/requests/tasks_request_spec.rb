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

    context 'when have pagination included' do
      let(:tasks) { create_list(:task, 6) }

      before do
        tasks

        get '/tasks', params: { page: 1, items: 2 }
      end

      it 'return the response body count' do
        expect(json_body.count).to eq(2)
      end
    end
  end

  describe 'POST#create' do
    context 'when create a task to the list' do
      let(:task_attributes) { attributes_for(:task) }

      before do
        task_attributes

        post '/tasks', params: { task: task_attributes }
      end

      it 'when the task is created' do
        expect(response).to have_http_status(:created)
        expect(json_body).to include(:id, :status, :description, :title)
      end
    end

    context 'when create a task with blank values' do
      let(:task_attributes) { attributes_for(:task, status: nil,
                                                    description: nil,
                                                    title: nil) }

      before do
        task_attributes

        post '/tasks', params: { task: task_attributes }
      end

      it 'when the task is not created' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_body).to include(:errors)
      end
    end
  end
end
