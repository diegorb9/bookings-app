# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  describe '#index' do
    let(:user) { create(:user) }
    let(:relation) { Booking.order(date: :asc) }

    before do
      Timecop.freeze('30/10/2019')

      sign_in(user)
    end

    after { Timecop.return }

    context 'when there is no date in params' do
      it 'renders listing page correctly' do
        expect(
          BookingsPresenter
        ).to receive(:new).once.with(relation, '30/10/2019'.to_date)

        get :index, params: {}

        expect(response).to render_template(:index)
      end
    end

    context 'when there is date in params' do
      it 'renders listing page correctly' do
        expect(
          BookingsPresenter
        ).to receive(:new).once.with(relation, '29/10/2019')

        get :index, params: { date: '29/10/2019' }

        expect(response).to render_template(:index)
      end
    end
  end
end
