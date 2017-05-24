class BookingsController < ApplicationController
  before_action :set_space, except: [:destroy]

  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
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
    params.require(:booking).permit(:id, :start_date, :end_date, :space_id, :user_id)
  end

  def set_space
    @space = Space.find(params[:space_id])
  end
end

