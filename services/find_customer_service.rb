# frozen_string_literal: true

require_relative 'find_service'
class FindCustomerService < FindService
  def self.call(params)
    new('Customer').call(**params)
  end
end
