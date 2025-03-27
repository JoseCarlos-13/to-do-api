# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TasksQuery', type: :query_object do # rubocop:disable Metrics/BlockLength
  context 'when have a filter' do # rubocop:disable Metrics/BlockLength
    context 'by status' do
      let(:user) { create(:user) }
      let(:params) { { status: 'cancelled' } }
      let(:tasks1) { create_list(:task, 2, user_id: user.id, status: 'cancelled') }
      let(:tasks2) { create_list(:task, 2, user_id: user.id, status: 'to_do') }

      before do
        tasks1
        tasks2

        @tasks = TasksQuery.new(params).call
      end

      it 'must return the cancelled tasks' do
        expect(@tasks[0][:status]).to eq('cancelled')
        expect(@tasks[1][:status]).to eq('cancelled')
      end
    end

    context 'by title' do
      let(:user) { create(:user) }
      let(:params) { { title: 'title1' } }
      let(:task1) { create(:task, title: 'title1', user_id: user.id, status: 'cancelled') }
      let(:task2) { create(:task, title: 'title2', user_id: user.id, status: 'to_do') }
      let(:task3) { create(:task, title: 'title3', user_id: user.id, status: 'to_do') }

      before do
        task1
        task2
        task3

        @tasks = TasksQuery.new(params).call
      end

      it 'must return the tasks through the title' do
        expect(@tasks[0][:title]).to eq('title1')
      end
    end

    context 'by user_name' do
      let(:user) { create(:user, name: 'MyString1') }
      let(:user2) { create(:user, name: 'MyString2') }
      let(:params) { { user_name: 'MyString1' } }
      let(:task1) { create(:task, title: 'title1', user_id: user.id, status: 'cancelled') }
      let(:task2) { create(:task, title: 'title2', user_id: user.id, status: 'to_do') }
      let(:task3) { create(:task, title: 'title3', user_id: user2.id, status: 'to_do') }

      before do
        task1
        task2
        task3

        @tasks = TasksQuery.new(params).call
      end

      it 'must return the tasks through the title' do
        expect(@tasks[0][:title]).to eq('title1')
        expect(@tasks[1][:title]).to eq('title2')
      end
    end

    context 'by multiple params applied' do
      let(:user) { create(:user, name: 'lala') }
      let(:user2) { create(:user, name: 'lulu') }
      let(:params) { { status: 'done', title: 'tle3', user_name: 'lulu' } }
      let(:task1) { create(:task, title: 'title1', user_id: user.id, status: 'cancelled') }
      let(:task2) { create(:task, title: 'title2', user_id: user.id, status: 'done') }
      let(:task3) { create(:task, title: 'title3', user_id: user2.id, status: 'done') }
      let(:task4) { create(:task, title: 'title4', user_id: user2.id, status: 'done') }

      before do
        task1
        task2
        task3
        task4

        @tasks = TasksQuery.new(params).call
      end

      it 'must return the tasks through the title' do
        expect(@tasks[0][:title]).to eq('title3')
      end
    end
  end
end
