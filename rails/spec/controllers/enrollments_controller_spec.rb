require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do
  describe "POST #create" do
    let(:student) { FactoryGirl.create(:student) }
    before { sign_in(student) }

    context 'valid params' do
      it 'returns http 200' do
        course = FactoryGirl.create(:course)
        post :create, enrollment: { code: course.code }
        expect(response.status).to eq(200)
      end
    end

    context 'invalid params' do
      it 'returns http 422' do
        post :create, enrollment: { code: 'abc123' }
        expect(response.status).to eq(422)
      end
    end
  end
end
