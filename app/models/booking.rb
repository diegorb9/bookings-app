# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user

  validates :description, :date, :time, presence: true
end
