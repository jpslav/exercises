require 'rails_helper'

module Api::V1
  describe ListsController, type: :controller do

    # This should return the minimal set of attributes required to create a valid
    # List. As you add validations to List, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) { { "name" => "MyString" } }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # ListsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET index" do
      it "assigns all lists as @lists" do
        list = List.create! valid_attributes
        get :index, {}, valid_session
        assigns(:lists).should eq([list])
      end
    end

    describe "GET show" do
      it "assigns the requested list as @list" do
        list = List.create! valid_attributes
        get :show, {:id => list.to_param}, valid_session
        assigns(:list).should eq(list)
      end
    end

    describe "GET new" do
      it "assigns a new list as @list" do
        get :new, {}, valid_session
        assigns(:list).should be_a_new(List)
      end
    end

    describe "GET edit" do
      it "assigns the requested list as @list" do
        list = List.create! valid_attributes
        get :edit, {:id => list.to_param}, valid_session
        assigns(:list).should eq(list)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new List" do
          expect {
            post :create, {:list => valid_attributes}, valid_session
          }.to change(List, :count).by(1)
        end

        it "assigns a newly created list as @list" do
          post :create, {:list => valid_attributes}, valid_session
          assigns(:list).should be_a(List)
          assigns(:list).should be_persisted
        end

        it "redirects to the created list" do
          post :create, {:list => valid_attributes}, valid_session
          response.should redirect_to(List.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved list as @list" do
          # Trigger the behavior that occurs when invalid params are submitted
          List.any_instance.stub(:save).and_return(false)
          post :create, {:list => { "name" => "invalid value" }}, valid_session
          assigns(:list).should be_a_new(List)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          List.any_instance.stub(:save).and_return(false)
          post :create, {:list => { "name" => "invalid value" }}, valid_session
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested list" do
          list = List.create! valid_attributes
          # Assuming there are no other lists in the database, this
          # specifies that the List created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          List.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
          put :update, {:id => list.to_param, :list => { "name" => "MyString" }}, valid_session
        end

        it "assigns the requested list as @list" do
          list = List.create! valid_attributes
          put :update, {:id => list.to_param, :list => valid_attributes}, valid_session
          assigns(:list).should eq(list)
        end

        it "redirects to the list" do
          list = List.create! valid_attributes
          put :update, {:id => list.to_param, :list => valid_attributes}, valid_session
          response.should redirect_to(list)
        end
      end

      describe "with invalid params" do
        it "assigns the list as @list" do
          list = List.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          List.any_instance.stub(:save).and_return(false)
          put :update, {:id => list.to_param, :list => { "name" => "invalid value" }}, valid_session
          assigns(:list).should eq(list)
        end

        it "re-renders the 'edit' template" do
          list = List.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          List.any_instance.stub(:save).and_return(false)
          put :update, {:id => list.to_param, :list => { "name" => "invalid value" }}, valid_session
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested list" do
        list = List.create! valid_attributes
        expect {
          delete :destroy, {:id => list.to_param}, valid_session
        }.to change(List, :count).by(-1)
      end

      it "redirects to the lists list" do
        list = List.create! valid_attributes
        delete :destroy, {:id => list.to_param}, valid_session
        response.should redirect_to(lists_url)
      end
    end

  end
end
