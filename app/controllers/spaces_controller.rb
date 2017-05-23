class SpacesController < ApplicationController

  before_action :set_space, except: [:new, :create]

  def index
    @spaces = Spaces.all
  end

  def create
    @space = Space.new(space_params)

  end

  def new

    @space = Space.new

  end

  def update

  end

  def show

  end


  private
  def space_params
    params.require(:product).permit(:address, :name, :photo, :type, :description, :country, :city, :rate, :user)
  end

  def set_space
    @space = Space.find(params[:user_id])
  end
end
