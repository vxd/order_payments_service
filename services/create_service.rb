# frozen_string_literal: true

class CreateService
  attr_reader :klass

  def initialize(klass_name)
    @klass = Object.const_get(klass_name)
  end

  private

  def permitted_params(hash)
    whitelist = @klass.const_get('PERMITTED_PARAMS') || []
    hash.deep_symbolize_keys.slice(*whitelist)
  end

  def create_resources(body)
    body.map { |resource| @klass.create(permitted_params(resource)) }
  end

  def resources_valid?(resources)
    resources.any?(&:valid?)
  end

  def valid_resources(resources)
    resources.select(&:valid?).map { |c| object_attributes(c) }
  end

  def invalid_resources(resources)
    resources.select(&:invalid?).map { |c| object_attributes(c) }
  end

  def object_attributes(object)
    hash = object.attributes.compact
    if object.valid?
      hash[:url] = object.url
    else
      hash[:errors] = object.errors.full_messages
    end
    hash
  end

  def response_failed(customers)
    { status: 409, body: { failed: invalid_resources(customers) } }
  end
end
