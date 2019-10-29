# frozen_string_literal: true

class BookingsController < ApplicationController
  respond_to :html, :js

  before_action :authenticate_user!

  def new
    @booking = current_user.bookings.new
  end

  def create
    @booking = current_user.bookings.create(booking_params)

    respond_with @booking, location: bookings_path
  end

  def index
    @bookings_presenter = BookingsPresenter.new(
      Booking.order(date: :asc),
      params[:date] || Date.today
    )
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :time, :description)
  end
end
