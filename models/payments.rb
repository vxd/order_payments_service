# frozen_string_literal: true

class Payments < ActiveRecord::Base
  PERMITTED_PARAMS = %i[order_id state payment_service].freeze
  STATE_OPTIONS = %w[unpaid paid error].freeze
  PAYMENT_SERVICES = %w[sberpay qiwi].freeze

  enum :state, STATE_OPTIONS

  validates :order_id, presence: true
  validates :state, presence: true, inclusion: { in: STATE_OPTIONS }
  validates :payment_service, presence: true, inclusion: { in: PAYMENT_SERVICES }

  belongs_to :order
end
