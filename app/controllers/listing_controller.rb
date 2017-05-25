class ListingController < ApplicationController
  before_action :set_space, except: [:destroy]
  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      redirect_to space_listing_index_path(@space)
    else
      render 'new'
    end
  end

  def show
    @listing = Listing.find(params[:id])

  end

  private
  def listing_params
    params.require(:listing).permit(:id, :start_date, :end_date, :space_id)
  end

  def set_space
    @space = Space.find(params[:space_id])
  end
end
