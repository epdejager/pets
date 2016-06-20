require 'rails_helper'

RSpec.describe OwnersController, :type => :controller do

  render_views

  describe "create" do
    describe "with valid params" do
    	it "should assign owner" do
      	post :create, owner: { name: "bob" } # format: :json
      	expect(assigns[:owner].name).to eq "bob"
    	end
    end

    describe "with invalid params" do
      let!(:owner) { FactoryGirl.create(:owner, :email => "bob@example.com") }      

      it "assigns a newly created owner unsaved" do
        allow_any_instance_of(Owner).to receive(:save).and_return(false)
        post :create, :owner => {}
        expect(assigns(:owner)).to be_a_new(Owner)
      end

      it "re-renders the 'new' template" do
        allow_any_instance_of(Owner).to receive(:save).and_return(false)
        post :create, :thing => {}
        expect(response).to render_template("new")
      end
    end
  end

  describe "show" do
    let(:owner) { FactoryGirl.create(:owner) }

    [:html, :json, :csv].each do |format|
      it "should respond to show with format #{format}" do
        get :show, id: owner.id, format: format
        expect(assigns[:owner]).to eq owner  
      end
    end
  end

  describe "delete" do
    let(:owner) { FactoryGirl.create(:owner) }

    it "delete should redirect to index" do
      get :destroy, id: owner.id
      expect(response).to redirect_to(owners_path)
    end
  end

  describe "index" do
    it "index" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end
end
