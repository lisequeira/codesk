class ListingController < ApplicationController

  before_action :set_space, except: [:destroy]
  before_action :require_same_user, except: [:index, :show]


  def index
    @listings = Listing.all
  end

  def new

    @listing = Listing.new

    @unavailable_dates = @space.listings.map do |l|
      if l.start_date.nil? || l.end_date.nil?
        []
      else
        (l.start_date.to_date..l.end_date.to_date).map(&:to_s)
      end
    end
    @unavailable_dates.flatten!

  end

  def create
    range = params[:daterange].split(" - ")
    start_date = range[0]
    end_date = range[1]

    @listing = Listing.new(listing_params)
    @listing.start_date = start_date
    @listing.end_date = end_date

    if @listing.save
      redirect_to( space_path(@space), notice: "You listed successfully")
    else
      flash[:alert] =  "UH OH! Something went wrong!"
      render 'new'
    end
  end

  def show
    @listing = Listing.find(params[:id])

  end

  private
  def listing_params
    params.require(:listing).permit(:id, :space_id)
  end

  def set_space
    @space = Space.find(params[:space_id])
  end

  def require_same_user
    if current_user != @space.user

      flash[:alert] =  "You can only list your own spaces"

      redirect_to root_path
    end
  end
end
