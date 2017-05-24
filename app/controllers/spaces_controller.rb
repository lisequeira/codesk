class SpacesController < ApplicationController

  before_action :set_space, except: [ :new, :create, :index, :current]

  def index
    @spaces = Space.all
  end

  def current
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
    @space.update(space_params)
    redirect_to space_path(@space)
  end

  def show
  end

  def edit
  end

  def destroy
    @space.destroy
    redirect_to spaces_path
  end


  private
  def space_params
    params.require(:space).permit(:address, :name, :photo, :type_space, :description, :country, :city, :user_id, rate_attributes:[:id, :hourly, :daily, :weekly, :monthly])
  end

  def set_space
    @space = Space.find(params[:id])
  end
end
