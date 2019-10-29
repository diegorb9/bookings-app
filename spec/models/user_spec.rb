# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:bookings) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'Abilities' do
    subject(:ability) { Ability.new(user) }

    let(:user) { build_stubbed(:user) }

    context 'when booking.user_id is equal the current_user.id' do
      let(:booking) { build_stubbed(:booking, user: user) }

      it { should be_able_to(:destroy, booking) }
    end
  end
end
