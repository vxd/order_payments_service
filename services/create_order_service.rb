# frozen_string_literal: true

require_relative 'create_service'
class CreateOrderService < CreateService
  def self.call(body)
    new('Order').call(body)
  end

  def call(body)
    resources = create_resources(body)

    return response_failed(resources) unless resources_valid?(resources)

    resources = ::OrderDecorator.decorate_collection(resources)

    {
      status: 201,
      body: {
        created: valid_resources(resources),
        failed: invalid_resources(resources)
      }
    }
  end
end
