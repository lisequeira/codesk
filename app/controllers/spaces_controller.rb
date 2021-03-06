class SpacesController < ApplicationController

  before_action :set_space, except: [ :new, :create, :index, :current]

  def index
    @spaces = Space.all
    @spaces = Space.search(params[:search]) if params[:search]

    @spaces = @spaces.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@spaces) do |space, marker|
      marker.lat space.latitude
      marker.lng space.longitude
      # inserir a fotografia aqui
      # marker.photo space.photo
    end
  end

  def current
    @spaces = Space.all
  end

  def create
    @space = Space.new(space_params)
    if @space.save
      redirect_to( space_path(@space), notice: "You got yourself a new space! Congratulations!")
    else
      render 'new'
    end
  end

  def new
    @space = Space.new
  end

  def update
    @space.update(space_params)
    redirect_to( space_path(@space), notice: "Your space has been updated")
  end

  def show
    @space_coordinates = [{ lat: @space.latitude, lng: @space.longitude }]
  end

  def edit
  end

  def destroy
    @space.destroy
    redirect_to( spaces_path, notice: "Your space has been deleted")
  end


  private
  def space_params
    params.require(:space).permit(:address, :name, :photo, :type_space, :description, :country, :city, :user_id, rate_attributes:[:id, :hourly, :daily, :weekly, :monthly])
  end

  def set_space
    @space = Space.find(params[:id])
  end
end
