# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:time) }

    describe 'uniqueness_of booking' do
      let(:date) { '30/10/2019' }
      let(:user) { create(:user) }

      before { create(:booking, date: date, user: user) }

      it 'returns error message' do
        booking = build(:booking, date: date, user: user)
        booking.valid?

        expect(
          booking.errors[:date]
        ).to eql(['já foi reservada para o horário escolhido'])
      end
    end
  end
end
