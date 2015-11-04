require 'rails_helper'

RSpec.describe StudentAssignmentsController, type: :controller do
  describe "PATCH #complete" do
    let(:student) { FactoryGirl.create(:student) }
    before { sign_in(student) }

    context 'valid params' do
      it 'returns http 200' do
        student_assignment = FactoryGirl.create(:student_assignment)
        patch :complete, id: student_assignment.id
        expect(response.status).to eq(200)
      end

      it 'marks completed as false' do
        student_assignment = FactoryGirl.create(:student_assignment)
        patch :complete, id: student_assignment.id
        student_assignment.reload
        expect(student_assignment.completed).to eq(true)
      end
    end
  end
end
