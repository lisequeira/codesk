class BookingsController < ApplicationController
  before_action :set_space, except: [:destroy]
  before_action :require_same_user, except: [:index, :show]

  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new

    @unavailable_datetime = @space.bookings.map do |l|
      if l.start_date.nil? || l.end_date.nil?
        []
      else
        (l.start_date.to_date..l.end_date.to_date).map(&:to_s)
      end
    end
    @unavailable_datetime.flatten!
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

  def require_same_user
    if current_user != @space.user
      flash[:danger]= "You can only edit your own profile"
      redirect_to root_path
    end
  end
end

