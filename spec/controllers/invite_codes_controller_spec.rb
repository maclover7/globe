require 'rails_helper'

RSpec.describe InviteCodesController, type: :controller do
  describe "GET #index" do
    let(:user) { FactoryGirl.create(:user, school_admin: true) }
    before { sign_in(user) }

    it "returns http 200" do
      get :index
      expect(response.status).to eq(200)
    end

    it "assigns all invite_codes as @invite_codes" do
      invite_code = FactoryGirl.create(:invite_code)
      get :index
      expect(assigns(:invite_codes)).to eq([invite_code])
    end
  end

  describe "GET #show" do
    let(:user) { FactoryGirl.create(:user, school_admin: true) }
    before { sign_in(user) }

    it "assigns the requested invite_code as @invite_code" do
      invite_code = FactoryGirl.create(:invite_code)
      get :show, id: invite_code.id
      expect(assigns(:invite_code)).to eq(invite_code)
    end
  end

  describe "GET #new" do
    let(:user) { FactoryGirl.create(:user, school_admin: true) }
    before { sign_in(user) }

    it "assigns a new invite_code as @invite_code" do
      get :new
      expect(assigns(:invite_code)).to be_a_new(InviteCode)
    end
  end

  describe "GET #edit" do
    let(:user) { FactoryGirl.create(:user, school_admin: true) }
    before { sign_in(user) }

    it "assigns the requested invite_code as @invite_code" do
      invite_code = FactoryGirl.create(:invite_code)
      get :edit, id: invite_code.id
      expect(assigns(:invite_code)).to eq(invite_code)
    end
  end

  describe "POST #create" do
    let(:user) { FactoryGirl.create(:user, school_admin: true) }
    before { sign_in(user) }

    context "with valid params" do
      it "creates a new InviteCode" do
        expect {
          post :create, invite_code: FactoryGirl.attributes_for(:invite_code)
        }.to change(InviteCode, :count).by(1)
      end

      it "assigns a newly created invite_code as @invite_code" do
        post :create, invite_code: FactoryGirl.attributes_for(:invite_code)
        expect(assigns(:invite_code)).to be_a(InviteCode)
        expect(assigns(:invite_code)).to be_persisted
      end

      it "redirects to the created invite_code" do
        post :create, invite_code: FactoryGirl.attributes_for(:invite_code)
        expect(response).to redirect_to(InviteCode.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved invite_code as @invite_code" do
        post :create, invite_code: FactoryGirl.attributes_for(:invite_code, code: nil)
        expect(assigns(:invite_code)).to be_a_new(InviteCode)
      end

      it "re-renders the 'new' template" do
        post :create, invite_code: FactoryGirl.attributes_for(:invite_code, code: nil)
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    let(:user) { FactoryGirl.create(:user, school_admin: true) }
    before { sign_in(user) }

    context "with valid params" do
      it "updates the requested invite_code" do
        invite_code = FactoryGirl.create(:invite_code)
        put :update, id: invite_code.id, invite_code: FactoryGirl.attributes_for(:invite_code, code: "hi")
        invite_code.reload
        expect(invite_code.code).to eq("hi")
      end

      it "assigns the requested invite_code as @invite_code" do
        invite_code = FactoryGirl.create(:invite_code)
        put :update, id: invite_code.id, invite_code: FactoryGirl.attributes_for(:invite_code, code: "hi")
        expect(assigns(:invite_code)).to eq(invite_code)
      end

      it "redirects to the invite_code" do
        invite_code = FactoryGirl.create(:invite_code)
        put :update, id: invite_code.id, invite_code: FactoryGirl.attributes_for(:invite_code, code: "hi")
        expect(response).to redirect_to(invite_code)
      end
    end

    context "with invalid params" do
      it "assigns the invite_code as @invite_code" do
        invite_code = FactoryGirl.create(:invite_code)
        put :update, id: invite_code.id, invite_code: FactoryGirl.attributes_for(:invite_code, code: nil)
        expect(assigns(:invite_code)).to eq(invite_code)
      end

      it "re-renders the 'edit' template" do
        invite_code = FactoryGirl.create(:invite_code)
        put :update, id: invite_code.id, invite_code: FactoryGirl.attributes_for(:invite_code, code: nil)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { FactoryGirl.create(:user, school_admin: true) }
    before { sign_in(user) }

    it "destroys the requested invite_code" do
      invite_code = FactoryGirl.create(:invite_code)
      expect {
        delete :destroy, id: invite_code.id
      }.to change(InviteCode, :count).by(-1)
    end

    it "redirects to the invite_codes list" do
      invite_code = FactoryGirl.create(:invite_code)
      delete :destroy, id: invite_code.id
      expect(response).to redirect_to(invite_codes_url)
    end
  end
end
