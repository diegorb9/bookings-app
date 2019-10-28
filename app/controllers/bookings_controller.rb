# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
