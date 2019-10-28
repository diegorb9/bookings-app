# frozen_string_literal: true

class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.time :time, null: false
      t.text :description, null: false

      t.timestamps
    end

    add_index :bookings, %i[date time], unique: true
  end
end
