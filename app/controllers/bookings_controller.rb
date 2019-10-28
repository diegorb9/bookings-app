# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings_presenter = BookingsPresenter.new(
      Booking.order(date: :asc),
      params[:date] || Date.today
    )
  end
end
