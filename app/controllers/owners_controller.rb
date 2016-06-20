class OwnersController < ApplicationController
  def index
  end

  def create
    @owner = Owner.new(params[:owner])

    if @owner.save
      redirect_to @owner
    else
      render :new
    end
  end

  def update
  end

  def show
    @owner = Owner.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @owner.to_json }
    end    
  end

  def destroy
    @owner = Owner.find(params[:id])
    @owner.destroy

    redirect_to owners_path
  end
end
