require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe "GET #index" do
    let(:student) { FactoryGirl.create(:student) }
    before { sign_in(student) }

    it "returns http 200" do
      get :index
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template('index')
    end
  end
end
