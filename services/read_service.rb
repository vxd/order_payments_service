# frozen_string_literal: true

class ReadService
  include Pagy::Backend

  attr_reader :klass

  def initialize(klass_name)
    @klass = Object.const_get(klass_name)
  end

  def call(params)
    per_page = (params[:per_page] || Pagy::DEFAULT[:items]).to_i
    pagy = Pagy.new(count: scope.count, items: per_page)

    begin
      pagy, resources = pagy(scope.all, items: per_page, page: params[:page] || 1)
      { total_pages: pagy.pages, current_page: pagy.page, resources: }
    rescue Pagy::OverflowError, Pagy::VariableError
      { error: 'Page not found', min_page: 1, max_page: pagy.pages }
    end
  end

  private

  def scope
    @klass
  end
end
