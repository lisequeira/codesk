require 'date'

class BookingsController < ApplicationController

  before_action :set_space, except: [:destroy]
  before_action :require_same_user, except: [:index, :show]


  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new

    @dates = (Date.today..6.months.from_now).map(&:to_s)
    @listings_slots = @space.listings.map do |l|
      if l.start_date.nil? || l.end_date.nil?
        []
      else
        (l.start_date.to_date..l.end_date.to_date).map(&:to_s)
      end
    end

    @listings_slots.flatten!

    @listings_slots.each do |s|
      @dates.delete(s)
    end

    @unavailable_dates = @space.bookings.map do |b|
      if b.start_date.nil? || b.end_date.nil?
        []
      else
        (b.start_date.to_date..b.end_date.to_date).map(&:to_s)
      end
    end

    @unavailable_dates.flatten!

    @unavailable_dates.each do |s|
      @dates.push(s) unless @dates.include? s
    end

  end

  def create
    range = params[:daterange].split(" - ")
    start_date = range[0]
    end_date = range[1]

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

      flash[:alert] = "You cannot book your own spaces"

      redirect_to root_path
    end
  end
end

