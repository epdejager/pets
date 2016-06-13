require 'rails_helper'

RSpec.describe OwnersController, :type => :controller do

  render_views

	it "should assign owner" do
  	post :create, owner: { name: "bob" } # format: :json
  	expect(assigns[:owner].name).to eq "bob"
	end

  it "show should redirect to index" do
    get :show
    expect(response).to redirect_to(owners_index_path)
  end

  it "show render index" do
    get :index
    expect(response).to have_http_status(:ok)
    expect(response.status).to eq(200)
    expect(response).to render_template(:index)
  end  
end
