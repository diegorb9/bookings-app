# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :destroy, Booking, user_id: user.id
  end
end
