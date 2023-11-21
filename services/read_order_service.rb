# frozen_string_literal: true

require_relative 'read_service'
class ReadOrderService < ReadService
  def self.call(params)
    new('Order').call(**params)
  end
end
