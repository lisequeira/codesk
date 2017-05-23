class SpacesController < ApplicationController

  before_action :set_space, except: [:new, :create, :index]

  def index
    @spaces = Space.all
  end

  def create
    @space = Space.new(space_params)
    if @space.save
      redirect_to spaces_path
    else
      render 'new'
    end


  end

  def new
    @space = Space.new
  end

  def update

  end

  def show

  end

  def edit
  end

  def destroy
    @space.destroy
  end


  private
  def space_params
    params.require(:space).permit(:address, :name, :photo, :type_space, :description, :country, :city, :user_id, rate_attributes:[:id, :hourly, :daily, :weekly, :monthly])
  end

  def set_space
    @space = Space.find(params[:id])
  end

  def spaces_types
  end
end
