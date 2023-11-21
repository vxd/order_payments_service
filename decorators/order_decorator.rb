# frozen_string_literal: true

require_relative 'resource_decorator'
class OrderDecorator < ResourceDecorator
  delegate_all
  def url
    "#{ENV.fetch('BASE_URL', 'http://localhost')}/orders/#{id}"
  end
end
