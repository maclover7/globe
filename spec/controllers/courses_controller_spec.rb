require 'rails_helper'

RSpec.describe CoursesController, type: :controller do

  describe "GET #index" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before { sign_in(teacher) }

    it "assigns all courses as @courses" do
      course = FactoryGirl.create(:course)
      get :index
      expect(assigns(:courses)).to eq([course])
    end
  end

  describe "GET #show" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before { sign_in(teacher) }

    it "assigns the requested course as @course" do
      course = FactoryGirl.create(:course, teacher_id: teacher.id)
      get :show, id: course.id
      expect(assigns(:course)).to eq(course)
    end
  end

  describe "GET #new" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before { sign_in(teacher) }

    it "assigns a new course as @course" do
      get :new
      expect(assigns(:course)).to be_a_new(Course)
    end
  end

  describe "GET #edit" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before { sign_in(teacher) }

    it "assigns the requested course as @course" do
      course = FactoryGirl.create(:course, teacher_id: teacher.id)
      get :edit, id: course.id
      expect(assigns(:course)).to eq(course)
    end
  end

  describe "POST #create" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before { sign_in(teacher) }

    context "with valid params" do
      it "creates a new Course" do
        expect {
          post :create, course: FactoryGirl.attributes_for(:course)
        }.to change(Course, :count).by(1)
      end

      it "assigns a newly created course as @course" do
        post :create, course: FactoryGirl.attributes_for(:course)
        expect(assigns(:course)).to be_a(Course)
        expect(assigns(:course)).to be_persisted
      end

      it "redirects to the created course" do
        post :create, course: FactoryGirl.attributes_for(:course)
        expect(response).to redirect_to(Course.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved course as @course" do
        post :create, course: FactoryGirl.attributes_for(:course, name: nil)
        expect(assigns(:course)).to be_a_new(Course)
      end

      it "re-renders the 'new' template" do
        post :create, course: FactoryGirl.attributes_for(:course, name: nil)
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before { sign_in(teacher) }

    context "with valid params" do
      it "updates the requested course" do
        course = FactoryGirl.create(:course)
        put :update, id: course.id, course: FactoryGirl.attributes_for(:course, name: "AmLit")
        course.reload
        expect(course.name).to eq("AmLit")
      end

      it "assigns the requested course as @course" do
        course = FactoryGirl.create(:course)
        put :update, id: course.id, course: FactoryGirl.attributes_for(:course, name: "AmLit")
        expect(assigns(:course)).to eq(course)
      end

      it "redirects to the course" do
        course = FactoryGirl.create(:course)
        put :update, id: course.id, course: FactoryGirl.attributes_for(:course, name: "AmLit")
        expect(response).to redirect_to(course)
      end
    end

    context "with invalid params" do
      it "assigns the course as @course" do
        course = FactoryGirl.create(:course)
        put :update, id: course.id, course: FactoryGirl.attributes_for(:course, name: nil)
        expect(assigns(:course)).to eq(course)
      end

      it "re-renders the 'edit' template" do
        course = FactoryGirl.create(:course)
        put :update, id: course.id, course: FactoryGirl.attributes_for(:course, name: nil)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let(:teacher) { FactoryGirl.create(:teacher) }
    before { sign_in(teacher) }

    it "destroys the requested course" do
      course = FactoryGirl.create(:course)
      expect {
        delete :destroy, id: course.id
      }.to change(Course, :count).by(-1)
    end

    it "returns http 200" do
      course = FactoryGirl.create(:course)
      delete :destroy, id: course.id
      expect(response.status).to eq(200)
    end
  end
end
