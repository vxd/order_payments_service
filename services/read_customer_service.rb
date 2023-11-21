# frozen_string_literal: true

require_relative 'read_service'
class ReadCustomerService < ReadService
  def self.call(params)
    new('Customer').call(**params)
  end
end
