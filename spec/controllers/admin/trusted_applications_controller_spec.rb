require 'rails_helper'

module Admin
  RSpec.describe TrustedApplicationsController, :type => :controller do

    # This should return the minimal set of attributes required to create a valid
    # TrustedApplication. As you add validations to TrustedApplication, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) {
      skip("Add a hash of attributes valid for your model")
    }

    let(:invalid_attributes) {
      skip("Add a hash of attributes invalid for your model")
    }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # TrustedApplicationsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET index" do
      it "assigns all trusted_applications as @trusted_applications" do
        trusted_application = TrustedApplication.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:trusted_applications)).to eq([trusted_application])
      end
    end

    describe "GET show" do
      it "assigns the requested trusted_application as @trusted_application" do
        trusted_application = TrustedApplication.create! valid_attributes
        get :show, {:id => trusted_application.to_param}, valid_session
        expect(assigns(:trusted_application)).to eq(trusted_application)
      end
    end

    describe "GET new" do
      it "assigns a new trusted_application as @trusted_application" do
        get :new, {}, valid_session
        expect(assigns(:trusted_application)).to be_a_new(TrustedApplication)
      end
    end

    describe "GET edit" do
      it "assigns the requested trusted_application as @trusted_application" do
        trusted_application = TrustedApplication.create! valid_attributes
        get :edit, {:id => trusted_application.to_param}, valid_session
        expect(assigns(:trusted_application)).to eq(trusted_application)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new TrustedApplication" do
          expect {
            post :create, {:trusted_application => valid_attributes}, valid_session
          }.to change(TrustedApplication, :count).by(1)
        end

        it "assigns a newly created trusted_application as @trusted_application" do
          post :create, {:trusted_application => valid_attributes}, valid_session
          expect(assigns(:trusted_application)).to be_a(TrustedApplication)
          expect(assigns(:trusted_application)).to be_persisted
        end

        it "redirects to the created trusted_application" do
          post :create, {:trusted_application => valid_attributes}, valid_session
          expect(response).to redirect_to(TrustedApplication.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved trusted_application as @trusted_application" do
          post :create, {:trusted_application => invalid_attributes}, valid_session
          expect(assigns(:trusted_application)).to be_a_new(TrustedApplication)
        end

        it "re-renders the 'new' template" do
          post :create, {:trusted_application => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        let(:new_attributes) {
          skip("Add a hash of attributes valid for your model")
        }

        it "updates the requested trusted_application" do
          trusted_application = TrustedApplication.create! valid_attributes
          put :update, {:id => trusted_application.to_param, :trusted_application => new_attributes}, valid_session
          trusted_application.reload
          skip("Add assertions for updated state")
        end

        it "assigns the requested trusted_application as @trusted_application" do
          trusted_application = TrustedApplication.create! valid_attributes
          put :update, {:id => trusted_application.to_param, :trusted_application => valid_attributes}, valid_session
          expect(assigns(:trusted_application)).to eq(trusted_application)
        end

        it "redirects to the trusted_application" do
          trusted_application = TrustedApplication.create! valid_attributes
          put :update, {:id => trusted_application.to_param, :trusted_application => valid_attributes}, valid_session
          expect(response).to redirect_to(trusted_application)
        end
      end

      describe "with invalid params" do
        it "assigns the trusted_application as @trusted_application" do
          trusted_application = TrustedApplication.create! valid_attributes
          put :update, {:id => trusted_application.to_param, :trusted_application => invalid_attributes}, valid_session
          expect(assigns(:trusted_application)).to eq(trusted_application)
        end

        it "re-renders the 'edit' template" do
          trusted_application = TrustedApplication.create! valid_attributes
          put :update, {:id => trusted_application.to_param, :trusted_application => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested trusted_application" do
        trusted_application = TrustedApplication.create! valid_attributes
        expect {
          delete :destroy, {:id => trusted_application.to_param}, valid_session
        }.to change(TrustedApplication, :count).by(-1)
      end

      it "redirects to the trusted_applications list" do
        trusted_application = TrustedApplication.create! valid_attributes
        delete :destroy, {:id => trusted_application.to_param}, valid_session
        expect(response).to redirect_to(trusted_applications_url)
      end
    end

  end
end
