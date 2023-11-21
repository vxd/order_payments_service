# frozen_string_literal: true

require_relative 'find_service'
class FindOrderService < FindService
  def self.call(params)
    new('Order').call(**params)
  end
end
