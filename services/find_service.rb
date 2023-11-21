# frozen_string_literal: true

class FindService
  attr_reader :klass

  def initialize(klass_name)
    @klass = Object.const_get(klass_name)
  end

  def call(params)
    @klass.find_by(id: params[:id])
  end
end
