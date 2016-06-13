class OwnersController < ApplicationController
  def index
  end

  def create
    @owner = Owner.new(params[:owner])

    respond_to do |format|
      format.html
      format.json { render json: @owner.to_json }
    end
  end

  def update
  end

  def show
    redirect_to owners_index_path
  end

  def delete
  end
end
