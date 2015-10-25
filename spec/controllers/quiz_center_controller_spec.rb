require 'rails_helper'

RSpec.describe QuizCenterController, type: :controller do
  describe "GET #index" do
    context "student" do
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

      it "assigns correct student_assignments as @assessments" do
        @course = FactoryGirl.create(:course)
        @enrollment = FactoryGirl.create(:enrollment)
        @assignment = FactoryGirl.create(:assignment, category: "Interactive Assessment")
        @student_assignment = FactoryGirl.create(:student_assignment)
        get :index
        expect(assigns(:assessments)).to eq([@student_assignment])
      end

      it "assigns correct student_assignments as @assessments" do
        @course = FactoryGirl.create(:course)
        @enrollment = FactoryGirl.create(:enrollment)
        @assignment = FactoryGirl.create(:assignment, category: "Quiz")
        @student_assignment = FactoryGirl.create(:student_assignment)
        get :index
        expect(assigns(:assessments)).to eq([])
      end
    end

    context "teacher" do
      let(:teacher) { FactoryGirl.create(:teacher) }
      before { sign_in(teacher) }

      it "returns http 200" do
        get :index
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template('index')
      end

      it "assigns correct assignments as @assessments" do
        @course = FactoryGirl.create(:course)
        @assignment = FactoryGirl.create(:assignment, category: "Interactive Assessment")
        get :index
        expect(assigns(:assessments)).to eq([@assignment])
      end

      it "assigns correct student_assignments as @assessments" do
        @course = FactoryGirl.create(:course)
        @assignment = FactoryGirl.create(:assignment, category: "Quiz")
        get :index
        expect(assigns(:assessments)).to eq([])
      end
    end
  end

  describe "GET #manage" do
    context "student" do
      let(:student) { FactoryGirl.create(:student) }
      before do
        sign_in(student)
        @assignment = FactoryGirl.create(:assignment)
        @student_assignment = FactoryGirl.create(:student_assignment)
      end

      it "redirects to root_path" do
        get :manage, id: @student_assignment.id
        expect(response).to redirect_to(root_path)
      end
    end

    context "teacher" do
      let(:teacher) { FactoryGirl.create(:teacher) }
      before do
        sign_in(teacher)
        @assignment = FactoryGirl.create(:assignment)
        @student_assignment = FactoryGirl.create(:student_assignment)
      end

      it "returns http 200" do
        get :manage, id: @assignment.id
        expect(response.status).to eq(200)
      end

      it "renders the manage template" do
        get :manage, id: @assignment.id
        expect(response).to render_template('manage')
      end
    end
  end

  describe "GET #take" do
    context "student" do
      let(:student) { FactoryGirl.create(:student) }
      before do
        sign_in(student)
        @assignment = FactoryGirl.create(:assignment)
        @student_assignment = FactoryGirl.create(:student_assignment)
      end

      it "returns http 200" do
        get :take, id: @student_assignment.id
        expect(response.status).to eq(200)
      end

      it "renders the take template" do
        get :take, id: @student_assignment.id
        expect(response).to render_template('take')
      end
    end

    context "teacher" do
      let(:teacher) { FactoryGirl.create(:teacher) }
      before do
        sign_in(teacher)
        @assignment = FactoryGirl.create(:assignment)
        @student_assignment = FactoryGirl.create(:student_assignment)
      end

      it "redirects to root_path" do
        get :take, id: @assignment.id
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
