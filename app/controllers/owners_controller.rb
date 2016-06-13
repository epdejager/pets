class OwnersController < ApplicationController
  def index
  end

  def create
    @owner = Owner.new(params[:owner])
  end

  def update
  end

  def show
  end

  def delete
  end
end
