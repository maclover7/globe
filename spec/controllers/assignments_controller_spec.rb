require 'rails_helper'

RSpec.describe AssignmentsController, type: :controller do
  describe "POST #create" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before { sign_in(teacher) }

    context 'valid params' do
      it 'returns http 200' do
        course = FactoryGirl.create(:course)
        post :create, course_id: course.id, assignment: FactoryGirl.attributes_for(:assignment)
        expect(response.status).to eq(200)
      end
    end

    context 'invalid params' do
      it 'returns http 422' do
        post :create, course_id: '42222', assignment: FactoryGirl.attributes_for(:assignment)
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT #update" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before { sign_in(teacher) }
    before { FactoryGirl.create(:course) }

    context "with valid params" do
      it "updates the requested assignment" do
        assignment = FactoryGirl.create(:assignment)
        put :update, assignment_id: assignment.id, assignment: FactoryGirl.attributes_for(:assignment, category: "Quiz")
        assignment.reload
        expect(assignment.category).to eq("Quiz")
      end

      it "redirects to the assignment's course" do
        assignment = FactoryGirl.create(:assignment)
        put :update, assignment_id: assignment.id, assignment: FactoryGirl.attributes_for(:assignment, category: "Quiz")
        expect(response).to redirect_to(assignment.course)
      end
    end

    context "with invalid params" do
      it "re-renders the 'edit' template" do
        assignment = FactoryGirl.create(:assignment)
        put :update, assignment_id: assignment.id, assignment: FactoryGirl.attributes_for(:assignment, name: nil)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before { sign_in(teacher) }

    it "destroys the requested assignment" do
      course = FactoryGirl.create(:course)
      assignment = FactoryGirl.create(:assignment)
      expect {
        delete :destroy, assignment_id: assignment.id, course_id: course.id
      }.to change(Assignment, :count).by(-1)
    end

    it "returns http 200" do
      course = FactoryGirl.create(:course)
      assignment = FactoryGirl.create(:assignment)
      delete :destroy, assignment_id: assignment.id, course_id: course.id
      expect(response.status).to eq(200)
    end
  end
end
