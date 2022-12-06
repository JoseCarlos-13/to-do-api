# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TasksQuery', type: :query_object do
  context 'when have a filter' do
    context 'by status' do
      let(:user) { create(:user) }
        let(:tasks1) { create_list(:task, 2, user_id: user.id, status: 'cancelled') }
        let(:tasks2) { create_list(:task, 2, user_id: user.id, status: 'to_do') }
  
        before do
          tasks1
          tasks2
  
          @query_response = TasksQuery.new('cancelled').by_status
        end
  
        it 'must return the cancelled tasks' do
          expect(@query_response[0][:status]).to eq('cancelled')
          expect(@query_response[1][:status]).to eq('cancelled')
        end
    end

    context 'by title' do
      let(:user) { create(:user) }
      let(:task1) { create(:task, title: 'title1', user_id: user.id, status: 'cancelled') }
      let(:task2) { create(:task, title: 'title2', user_id: user.id, status: 'to_do') }
      let(:task3) { create(:task, title: 'title3', user_id: user.id, status: 'to_do') }

      before do
        task1
        task2
        task3

        @query_response = TasksQuery.new('title1').by_title
      end

      it 'must return the tasks through the title' do
        expect(@query_response[0][:title]).to eq('title1')
      end
    end

    context 'by user_name' do
      let(:user) { create(:user, name: 'MyString1') }
      let(:user2) { create(:user, name: 'MyString2') }
      let(:task1) { create(:task, title: 'title1', user_id: user.id, status: 'cancelled') }
      let(:task2) { create(:task, title: 'title2', user_id: user.id, status: 'to_do') }
      let(:task3) { create(:task, title: 'title3', user_id: user2.id, status: 'to_do') }

      before do
        task1
        task2
        task3

        @query_response = TasksQuery.new('MyString1').by_user_name
      end

      it 'must return the tasks through the title' do
        expect(@query_response[0][:title]).to eq('title1')
        expect(@query_response[1][:title]).to eq('title2')
      end
    end
  end
end
