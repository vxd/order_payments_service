# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :payment_service, null: false
      t.string :state, null: false, default: 'unpaid'
      t.belongs_to :order, type: :uuid, index: true
      t.timestamps
    end
  end
end
