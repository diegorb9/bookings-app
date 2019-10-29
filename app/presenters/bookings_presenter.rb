# frozen_string_literal: true

class BookingsPresenter
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

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
    (6..23).to_a.map { |h| formatted_hour(h) }
  end

  def reservation_text(booking)
    I18n.t(
      :reserved_for,
      user_name: booking.user.name, scope: %i[pages bookings index]
    )
  end

  def availability_text(day, hour, based_on = DateTime.current)
    parsed_date = Time.parse("#{day} #{hour}")
    return '-' if based_on > parsed_date

    link_to(
      'Disponível', new_booking_path(date: day, time: formatted_hour(hour.to_i)),
      remote: true, class: 'link'
    )
  end

  private

  attr_reader :relation, :date

  def formatted_hour(hour)
    "#{format('%.2d', hour)}:00"
  end
end
