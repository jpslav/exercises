require 'rails_helper'

module Api::V1
  describe AuthorsController, type: :controller do

    # This should return the minimal set of attributes required to create a valid
    # Author. As you add validations to Author, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) { { "number" => "1" } }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # AuthorsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET index" do
      it "assigns all authors as @authors" do
        author = Author.create! valid_attributes
        get :index, {}, valid_session
        assigns(:authors).should eq([author])
      end
    end

    describe "GET show" do
      it "assigns the requested author as @author" do
        author = Author.create! valid_attributes
        get :show, {:id => author.to_param}, valid_session
        assigns(:author).should eq(author)
      end
    end

    describe "GET new" do
      it "assigns a new author as @author" do
        get :new, {}, valid_session
        assigns(:author).should be_a_new(Author)
      end
    end

    describe "GET edit" do
      it "assigns the requested author as @author" do
        author = Author.create! valid_attributes
        get :edit, {:id => author.to_param}, valid_session
        assigns(:author).should eq(author)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Author" do
          expect {
            post :create, {:author => valid_attributes}, valid_session
          }.to change(Author, :count).by(1)
        end

        it "assigns a newly created author as @author" do
          post :create, {:author => valid_attributes}, valid_session
          assigns(:author).should be_a(Author)
          assigns(:author).should be_persisted
        end

        it "redirects to the created author" do
          post :create, {:author => valid_attributes}, valid_session
          response.should redirect_to(Author.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved author as @author" do
          # Trigger the behavior that occurs when invalid params are submitted
          Author.any_instance.stub(:save).and_return(false)
          post :create, {:author => { "number" => "invalid value" }}, valid_session
          assigns(:author).should be_a_new(Author)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Author.any_instance.stub(:save).and_return(false)
          post :create, {:author => { "number" => "invalid value" }}, valid_session
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested author" do
          author = Author.create! valid_attributes
          # Assuming there are no other authors in the database, this
          # specifies that the Author created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Author.any_instance.should_receive(:update_attributes).with({ "number" => "1" })
          put :update, {:id => author.to_param, :author => { "number" => "1" }}, valid_session
        end

        it "assigns the requested author as @author" do
          author = Author.create! valid_attributes
          put :update, {:id => author.to_param, :author => valid_attributes}, valid_session
          assigns(:author).should eq(author)
        end

        it "redirects to the author" do
          author = Author.create! valid_attributes
          put :update, {:id => author.to_param, :author => valid_attributes}, valid_session
          response.should redirect_to(author)
        end
      end

      describe "with invalid params" do
        it "assigns the author as @author" do
          author = Author.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Author.any_instance.stub(:save).and_return(false)
          put :update, {:id => author.to_param, :author => { "number" => "invalid value" }}, valid_session
          assigns(:author).should eq(author)
        end

        it "re-renders the 'edit' template" do
          author = Author.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Author.any_instance.stub(:save).and_return(false)
          put :update, {:id => author.to_param, :author => { "number" => "invalid value" }}, valid_session
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested author" do
        author = Author.create! valid_attributes
        expect {
          delete :destroy, {:id => author.to_param}, valid_session
        }.to change(Author, :count).by(-1)
      end

      it "redirects to the authors list" do
        author = Author.create! valid_attributes
        delete :destroy, {:id => author.to_param}, valid_session
        response.should redirect_to(authors_url)
      end
    end

  end
end
