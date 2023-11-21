# frozen_string_literal: true

class ResourceDecorator < Draper::Decorator
  def url
    ENV.fetch('BASE_URL', 'http://localhost').to_s
  end
end
