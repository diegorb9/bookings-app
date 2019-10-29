# frozen_string_literal: true

class BookingsController < ApplicationController
  respond_to :html, :js

  before_action :authenticate_user!
  before_action :set_booking, only: %i[edit update show destroy]

  def index
    @bookings_presenter = BookingsPresenter.new(
      Booking.order(date: :asc),
      params[:date] || Date.today
    )
  end

  def new
    @booking = current_user.bookings.new
  end

  def create
    @booking = current_user.bookings.create(booking_params)

    respond_with @booking, location: bookings_path
  end

  def show; end

  def edit
    authorize! :update, @booking
  end

  def update
    authorize! :update, @booking
    @booking.update(booking_params)

    respond_with @booking, location: bookings_path
  end

  def destroy
    authorize! :destroy, @booking

    @booking.destroy
    respond_with @booking, location: bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :time, :description)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
