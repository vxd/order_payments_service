# frozen_string_literal: true

class ResourceDecorator < Draper::Decorator
  def url(_id)
    ENV.fetch('BASE_URL', 'http://localhost').to_s
  end
end
