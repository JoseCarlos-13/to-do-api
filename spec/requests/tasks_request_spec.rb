require 'rails_helper'
require 'support/request_helper_spec.rb'

RSpec.describe "Tasks", type: :request do
  describe "GET#index" do
    context "when have much task created" do
      it "return response status code and the tasks created" do
        tasks = create_list(:task, 3)

        get "/tasks"

        expect(response).to have_http_status(:ok)
        expect(json_body[0]).to have_key(:id)
        expect(json_body[0]).to have_key(:title)
        expect(json_body[0]).to have_key(:description)
        expect(json_body[0]).to have_key(:status)
      end
    end
  end
end
