require 'rails_helper'

RSpec.describe QuizCenterController, type: :controller do
  describe "GET #index --> student" do
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

  describe "GET #index --> teacher" do
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
