class ListingController < ApplicationController

  def new
    @listing = Listing.new
  end
end
