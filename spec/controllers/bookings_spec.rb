# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:user) { create(:user) }
  let(:relation) { Booking.order(date: :asc) }

  before do
    Timecop.freeze('30/10/2019')

    sign_in(user)
  end

  after { Timecop.return }

  describe '#index' do
    context 'when there is no date in params' do
      it 'renders listing page correctly' do
        expect(
          BookingsPresenter
        ).to receive(:new).once.with(relation, '30/10/2019'.to_date)

        get :index

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

  describe '#new' do
    it 'renders :new template' do
      get :new, xhr: true

      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    context 'when success' do
      it 'creates a new booking' do
        expect do
          post :create,
               params: {
                 booking: { date: '31/10/2019', time: '08:00:00', description: 'foo' }
               },
               xhr: true
        end.to change(Booking, :count).by(1)
      end
    end

    context 'when failure' do
      it 'does not create a booking' do
        expect do
          post :create,
               params: {
                 booking: { date: '31/10/2019' }
               },
               xhr: true
        end.not_to change(Booking, :count)
      end
    end
  end

  describe '#destroy' do
    context 'when success' do
      let(:booking) { create(:booking, date: '30/10/2019', user: user) }

      it 'destroys the booking' do
        expect do
          delete :destroy, params: { id: booking.id }, xhr: true
        end.to change(Booking, :count).by(0)
      end
    end

    context 'when failure' do
      let(:user1) { create(:user, email: 'foo@example.com') }
      let(:booking) { create(:booking, date: '30/10/2019', user: user1) }

      it 'redirects to root_path' do
        delete :destroy, params: { id: booking.id }, xhr: true

        expect(response).to redirect_to(root_url)
      end
    end
  end
end
