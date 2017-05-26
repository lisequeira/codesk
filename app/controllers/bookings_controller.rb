require 'date'

class BookingsController < ApplicationController

  before_action :set_space, except: [:destroy]
  before_action :require_same_user, except: [:show, :index]

  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new

    @unavailable_dates = @space.bookings.map do |b|
      if b.start_date.nil? || b.end_date.nil?
        []
      else
        (b.start_date.to_date..b.end_date.to_date).map(&:to_s)
      end
    end
    @unavailable_dates.flatten!

    @space_listings = [Date.today]

    @space_listings << @space.listings.order('start_date ASC')


    (0..@space_listings.lenght).step(2) do |i|
      if i == 0 &&
        @unavailable_dates << @space_listings[i]...
      end

@space_listings.map do |l|

    end

  end

  def create
    range = params[:daterange].split(" - ")
    start_date = range[0]
    end_date = range[1]

    @booking = Booking.new(booking_params)
    @booking = Booking.new(booking_params)
    @booking.start_date = start_date
    @booking.end_date = end_date


    if @booking.save
      redirect_to space_booking_path(@space, @booking)
    else
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])

  end

  private
  def booking_params
    params.require(:booking).permit(:id, :space_id, :user_id)
  end

  def set_space
    @space = Space.find(params[:space_id])
  end

  def require_same_user
    if current_user == @space.user
      flash[:danger]= "You cannot book your own spaces"
      redirect_to root_path
    end
  end
end

