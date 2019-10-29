# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user

  validates :description, :date, :time, presence: true
  validates :date, uniqueness: {
    scope: :time, message: I18n.t('.errors.messages.already_reserved')
  }
end
