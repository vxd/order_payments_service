# frozen_string_literal: true

require_relative 'resource_decorator'
class CustomerDecorator < ResourceDecorator
  delegate_all
  def url
    "#{ENV.fetch('BASE_URL', 'http://localhost')}/customers/#{id}"
  end
end
