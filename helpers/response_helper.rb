# frozen_string_literal: true

module ResponseHelper
  def post_bulk_customers(body)
    customers = create_customers(body)

    return response_failed(customers) unless customers_valid?(customers)

    {
      status: 201,
      body: {
        created: valid_customers(customers),
        failed: invalid_customers(customers)
      }
    }
  end

  private

  def create_customers(body)
    body.map { |customer| Customer.create(permitted_params(customer)) }
  end

  def customers_valid?(customers)
    customers.any?(&:valid?)
  end

  def valid_customers(customers)
    customers.select(&:valid?).map { |c| object_attributes(c) }
  end

  def invalid_customers(customers)
    customers.select(&:invalid?).map { |c| object_attributes(c) }
  end

  def object_attributes(object)
    hash = object.attributes.compact
    if object.valid?
      hash[:url] = url(object.id)
    else
      hash[:errors] = object.errors.full_messages
    end
    hash
  end

  def url(id)
    "#{ENV.fetch('BASE_URL', 'http://localhost')}/customers/#{id}"
  end

  def response_failed(customers)
    { status: 409, body: { failed: invalid_customers(customers) } }
  end
end
