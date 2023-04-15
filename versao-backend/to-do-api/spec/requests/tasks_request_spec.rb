# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :request do # rubocop:disable Metrics/BlockLength
  describe 'GET#index' do # rubocop:disable Metrics/BlockLength
    context 'when have much task created' do
      let(:user) { create(:user) }
      let(:tasks) { create_list(:task, 3, user_id: user.id) }

      before do
        tasks

        get '/tasks'
      end

      it 'must return the 200 status code and the tasks created' do
        expect(response).to have_http_status(:ok)
        expect(json_body[0]).to have_key(:id)
        expect(json_body[0]).to have_key(:title)
        expect(json_body[0]).to have_key(:status)
      end
    end

    context 'when have pagination included' do
      let(:user) { create(:user) }
      let(:tasks) { create_list(:task, 6, user_id: user.id) }

      before do
        tasks

        get '/tasks', params: { page: 1, items: 2 }
      end

      it 'must return the response body count' do
        expect(json_body.count).to eq(2)
      end
    end

    context 'when have a filter' do # rubocop:disable Metrics/BlockLength
      context 'by status applied' do
        let(:user) { create(:user) }
        let(:tasks1) { create_list(:task, 2, user_id: user.id, status: 'cancelled') }
        let(:tasks2) { create_list(:task, 2, user_id: user.id, status: 'to_do') }

        before do
          tasks1
          tasks2

          get '/tasks', params: { status: 'cancelled' }
        end

        it 'must return the cancelled tasks' do
          expect(json_body[0][:status]).to eq('cancelled')
          expect(json_body[1][:status]).to eq('cancelled')
        end
      end

      context 'by title applied' do
        let(:user) { create(:user) }
        let(:task1) { create(:task, title: 'title1', user_id: user.id, status: 'cancelled') }
        let(:task2) { create(:task, title: 'title2', user_id: user.id, status: 'to_do') }
        let(:task3) { create(:task, title: 'title3', user_id: user.id, status: 'to_do') }

        before do
          task1
          task2
          task3

          get '/tasks', params: { title: 'title1' }
        end

        it 'must return the tasks through the title' do
          expect(json_body[0][:title]).to eq('title1')
        end
      end

      context 'by user_name applied' do
        let(:user) { create(:user, name: 'MyString1') }
        let(:user2) { create(:user, name: 'MyString2') }
        let(:task1) { create(:task, title: 'title1', user_id: user.id, status: 'cancelled') }
        let(:task2) { create(:task, title: 'title2', user_id: user.id, status: 'to_do') }
        let(:task3) { create(:task, title: 'title3', user_id: user2.id, status: 'to_do') }

        before do
          task1
          task2
          task3

          get '/tasks', params: { user_name: 'MyString1' }
        end

        it 'must return the tasks through the title' do
          expect(json_body[0][:title]).to eq('title1')
          expect(json_body[1][:title]).to eq('title2')
        end
      end

      context 'by multiple params applied' do
        let(:user) { create(:user) }
        let(:task1) { create(:task, title: 'title1', user_id: user.id, status: 'cancelled') }
        let(:task2) { create(:task, title: 'title2', user_id: user.id, status: 'done') }
        let(:task3) { create(:task, title: 'title3', user_id: user.id, status: 'done') }
        let(:task4) { create(:task, title: 'title4', user_id: user.id, status: 'done') }

        before do
          task1
          task2
          task3
          task4

          get '/tasks', params: { status: 'done', title: 'le3' }
        end

        it 'must return the tasks through the title' do
          expect(json_body[0][:title]).to eq('title3')
        end
      end

      context 'by user_name applied' do
        let(:user) { create(:user, name: 'MyString1') }
        let(:user2) { create(:user, name: 'MyString2') }
        let(:task1) { create(:task, title: 'title1', user_id: user.id, status: 'cancelled') }
        let(:task2) { create(:task, title: 'title2', user_id: user.id, status: 'to_do') }
        let(:task3) { create(:task, title: 'title3', user_id: user2.id, status: 'to_do') }

        before do
          task1
          task2
          task3

          get '/tasks', params: { user_name: 'MyString1' }
        end

        it 'must return the tasks through the title' do
          expect(json_body[0][:title]).to eq('title1')
          expect(json_body[1][:title]).to eq('title2')
        end
      end
    end
  end

  describe 'POST#create' do
    context 'when create a task to the list' do
      let(:user) { create(:user) }
      let(:task_attributes) { attributes_for(:task, user_id: user.id) }

      before do
        task_attributes

        post '/tasks', params: { task: task_attributes }
      end

      it 'must return the 201 status code and the task attributes' do
        expect(response).to have_http_status(:created)
        expect(json_body).to include(:id, :status, :description, :title)
      end
    end

    context 'when create a task with blank values' do
      let(:user) { create(:user) }
      let(:task_attributes) { attributes_for(:task, status: nil, title: nil, description: nil, user_id: user.id) }

      before do
        task_attributes

        post '/tasks', params: { task: task_attributes }
      end

      it 'must return the 422 status code and message errors' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_body).to include(:errors)
      end
    end
  end

  describe 'GET#show' do
    context 'when a task is selected for to be readed' do
      let!(:user) { create(:user) }
      let!(:task) { create(:task, user_id: user.id) }

      before do
        task

        get "/tasks/#{task.id}"
      end

      it 'must return the 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return all task attributes' do
        expect(json_body).to include(:id, :title, :status, :description)
      end
    end
  end

  describe 'DELETE#destroy' do
    let!(:user) { create(:user) }
    let!(:task) { create(:task, user_id: user.id) }

    before do
      user
      task

      delete "/tasks/#{task.id}"
    end

    it 'must return 204 status code' do
      expect(response).to have_http_status(:no_content)
    end

    it 'must to verify if the task was removed' do
      expect(Task.count).to eq(0)
    end
  end
end
