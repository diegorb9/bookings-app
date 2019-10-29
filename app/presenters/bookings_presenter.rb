# frozen_string_literal: true

class BookingsPresenter
  include Rails.application.routes.url_helpers

  def initialize(relation, date)
    @relation = relation
    @date = date.to_date
  end

  def records
    relation.where(date: beginning_of_week..end_of_week)
  end

  def beginning_of_week
    date.beginning_of_week
  end

  def end_of_week
    date.end_of_week - 2.days
  end

  def previous_link
    bookings_path(date: beginning_of_week - 1.week)
  end

  def current_week_link
    bookings_path(date: Date.today)
  end

  def next_link
    bookings_path(date: beginning_of_week + 1.week)
  end

  def listable_hours
    (6..23).to_a.map { |h| "#{format('%.2d', h)}:00" }
  end

  def availability_text(booking)
    I18n.t(
      :reserved_for,
      user_name: booking.user.name, scope: %i[pages bookings index]
    )
  end

  private

  attr_reader :relation, :date
end
