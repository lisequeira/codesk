class SpacesController < ApplicationController

  before_action :set_space, except: [ :new, :create, :index, :current]

  def index
    @spaces = Space.all
    if params[:search]
      @spaces = Space.search(params[:search]).order("created_at DESC")
    else
      @spaces = Space.all.order('created_at DESC')
    end

    @spaces = Space.where.not(latitude: nil, longitude: nil)

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
    @space_coordinates = [{ lat: @space.latitude, lng: @space.longitude }]
  end

  def edit
  end

  def destroy
    @space.destroy
    redirect_to spaces_path
  end


  private
  def space_params
    params.require(:space).permit(:search, :address, :name, :photo, :type_space, :description, :country, :city, :user_id, rate_attributes:[:id, :hourly, :daily, :weekly, :monthly])
  end

  def set_space
    @space = Space.find(params[:id])
  end
end
