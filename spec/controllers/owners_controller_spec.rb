require 'rails_helper'

RSpec.describe OwnersController, :type => :controller do

	it "should assign owner" do
    post :create, owner: { name: "bob" } # format: :json
    expect(assigns[:owner].name).to eq "bob"
	end

end
