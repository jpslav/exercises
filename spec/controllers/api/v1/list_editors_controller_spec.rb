require 'rails_helper'

module Api::V1
  describe ListEditorsController, type: :controller do

    # This should return the minimal set of attributes required to create a valid
    # ListEditor. As you add validations to ListEditor, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) { { "list_id" => "1" } }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # ListEditorsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET index" do
      it "assigns all list_editors as @list_editors" do
        list_editor = ListEditor.create! valid_attributes
        get :index, {}, valid_session
        assigns(:list_editors).should eq([list_editor])
      end
    end

    describe "GET show" do
      it "assigns the requested list_editor as @list_editor" do
        list_editor = ListEditor.create! valid_attributes
        get :show, {:id => list_editor.to_param}, valid_session
        assigns(:list_editor).should eq(list_editor)
      end
    end

    describe "GET new" do
      it "assigns a new list_editor as @list_editor" do
        get :new, {}, valid_session
        assigns(:list_editor).should be_a_new(ListEditor)
      end
    end

    describe "GET edit" do
      it "assigns the requested list_editor as @list_editor" do
        list_editor = ListEditor.create! valid_attributes
        get :edit, {:id => list_editor.to_param}, valid_session
        assigns(:list_editor).should eq(list_editor)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new ListEditor" do
          expect {
            post :create, {:list_editor => valid_attributes}, valid_session
          }.to change(ListEditor, :count).by(1)
        end

        it "assigns a newly created list_editor as @list_editor" do
          post :create, {:list_editor => valid_attributes}, valid_session
          assigns(:list_editor).should be_a(ListEditor)
          assigns(:list_editor).should be_persisted
        end

        it "redirects to the created list_editor" do
          post :create, {:list_editor => valid_attributes}, valid_session
          response.should redirect_to(ListEditor.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved list_editor as @list_editor" do
          # Trigger the behavior that occurs when invalid params are submitted
          ListEditor.any_instance.stub(:save).and_return(false)
          post :create, {:list_editor => { "list_id" => "invalid value" }}, valid_session
          assigns(:list_editor).should be_a_new(ListEditor)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          ListEditor.any_instance.stub(:save).and_return(false)
          post :create, {:list_editor => { "list_id" => "invalid value" }}, valid_session
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested list_editor" do
          list_editor = ListEditor.create! valid_attributes
          # Assuming there are no other list_editors in the database, this
          # specifies that the ListEditor created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          ListEditor.any_instance.should_receive(:update_attributes).with({ "list_id" => "1" })
          put :update, {:id => list_editor.to_param, :list_editor => { "list_id" => "1" }}, valid_session
        end

        it "assigns the requested list_editor as @list_editor" do
          list_editor = ListEditor.create! valid_attributes
          put :update, {:id => list_editor.to_param, :list_editor => valid_attributes}, valid_session
          assigns(:list_editor).should eq(list_editor)
        end

        it "redirects to the list_editor" do
          list_editor = ListEditor.create! valid_attributes
          put :update, {:id => list_editor.to_param, :list_editor => valid_attributes}, valid_session
          response.should redirect_to(list_editor)
        end
      end

      describe "with invalid params" do
        it "assigns the list_editor as @list_editor" do
          list_editor = ListEditor.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          ListEditor.any_instance.stub(:save).and_return(false)
          put :update, {:id => list_editor.to_param, :list_editor => { "list_id" => "invalid value" }}, valid_session
          assigns(:list_editor).should eq(list_editor)
        end

        it "re-renders the 'edit' template" do
          list_editor = ListEditor.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          ListEditor.any_instance.stub(:save).and_return(false)
          put :update, {:id => list_editor.to_param, :list_editor => { "list_id" => "invalid value" }}, valid_session
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested list_editor" do
        list_editor = ListEditor.create! valid_attributes
        expect {
          delete :destroy, {:id => list_editor.to_param}, valid_session
        }.to change(ListEditor, :count).by(-1)
      end

      it "redirects to the list_editors list" do
        list_editor = ListEditor.create! valid_attributes
        delete :destroy, {:id => list_editor.to_param}, valid_session
        response.should redirect_to(list_editors_url)
      end
    end

  end
end
