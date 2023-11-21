# frozen_string_literal: true

class Order < ActiveRecord::Base
  PERMITTED_PARAMS = %i[total user_id].freeze

  validates :user_id, presence: true
  validates :total, presence: true

  # belongs_to :customer
end
