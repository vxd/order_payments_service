# frozen_string_literal: true

require 'bundler'
Bundler.require

def require_files(directory)
  Dir["./#{directory}/*.rb"].each { |file| require file }
end

directories = %w[models decorators services serializers]
directories.each { |directory| require_files(directory) }

require_relative 'helpers/request_helper'

Dotenv.load

class MyApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  helpers RequestHelper
  # helpers ResponseHelper

  configure do
    db_options = {
      adapter: 'postgresql',
      host: ENV.fetch('DB_HOST', 'localhost'),
      database: ENV.fetch('DB_NAME', 'database_app'),
      user: ENV.fetch('DB_USER', 'user_name'),
      password: ENV.fetch('DB_PASS', 'user_password')
    }

    set :database, db_options
  end

  before do
    content_type :json
    halt 401 unless request.env['HTTP_X_API_KEY'] == ENV['API_KEY']
  end

  not_found do
    { status: 404, error: 'Resource not found' }.to_json
  end

  post '/customers' do
    @body = parse_request_body(request.body.read)
    halt 400, { error: 'Bad request. Should be an array' }.to_json unless @body.is_a?(Array)
    result = CreateCustomerService.call(@body)
    halt result[:status], result[:body].to_json
  end

  get '/customers' do
    customers = ::ReadCustomerService.call(per_page: params[:per_page])
    customers[:error] ? (halt 400, customers.to_json) : customers.to_json
  end

  get '/customers/:id' do
    customer = ::FindCustomerService.call(id: params[:id])
    customer ? customer.to_json : (halt 404, { error: 'Customer not found' }.to_json)
  end

  get '/orders' do
    orders = ::ReadOrderService.call(per_page: params[:per_page])
    orders[:error] ? (halt 400, orders.to_json) : orders.to_json
  end

  get '/orders/:id' do
    customer = ::FindOrderService.call(id: params[:id])
    customer ? customer.to_json : (halt 404, { error: 'Customer not found' }.to_json)
  end

  post '/orders' do
    @body = parse_request_body(request.body.read)
    halt 400, { error: 'Bad request. Should be an array' }.to_json unless @body.is_a?(Array)
    result = CreateOrderService.call(@body)
    halt result[:status], result[:body].to_json
  end

  post '/payments' do
    halt 500, { error: 'The service is temporarily unavailable' }.to_json
  end

  run! if app_file == $PROGRAM_NAME
end
