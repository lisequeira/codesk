class ListingController < ApplicationController
  before_action :set_space, except: [:destroy]

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      redirect_to space_listing_path
    else
      render 'new'
    end
  end

  private
  def listing_params

  end

  def set_space
    @space = Space.find(params[:space_id])
  end
end
