require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET #auth" do
    it "returns http 200" do
      get :auth
      expect(response.status).to eq(200)
    end

    it "renders the auth template" do
      get :auth
      expect(response).to render_template('auth')
    end
  end

  describe "GET #home" do
    it "returns http 200" do
      get :home
      expect(response.status).to eq(200)
    end

    it "renders the home template" do
      get :home
      expect(response).to render_template('home')
    end
  end
end
