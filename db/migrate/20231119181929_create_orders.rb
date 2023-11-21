# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  create_table :orders, id: :uuid do |t|
    t.float :total, null: false, default: 0
    t.belongs_to :customer, index: true
    t.timestamps
  end
end
