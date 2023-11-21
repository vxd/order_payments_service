# frozen_string_literal: true

require 'spec_helper'
# rubocop:disable Metrics/BlockLength
describe Order do
  let(:api_key) { 'put_here_an_api_key' }
  let(:headers) { { 'Accept' => 'application/json', 'HTTP_X_API_KEY' => api_key } }
  let(:customers) { Customer.create!(json_data(filename: 'customers')) }

  context 'GET to /orders' do
    let(:response) { get '/orders', nil, headers }
    let(:attributes) { json_data(filename: 'orders') }

    let!(:orders) { Order.create!(attributes) }

    context 'invalid api-key' do
      let(:api_key) { '' }
      it 'returns status 401' do
        expect(response.status).to eq 401
      end
    end

    context 'valid api-key' do
      it 'returns status 200 OK' do
        expect(response.status).to eq 200
      end
      it 'returns an array of orders' do
        expect(response.body).to include(orders.to_json)
      end
    end
  end

  context 'POST to /orders' do
    let(:api_key) { 'put_here_an_api_key' }
    let(:request) { post '/orders', post_data.to_json, headers }
    let(:post_data) { json_data(filename: 'orders') }

    context 'valid params' do
      it 'shows response ok and valid type' do
        expect { request }.to change(Order, :count).by(2)
      end
    end

    context 'invalid params' do
      before { request }
      context 'invalid api key' do
        let(:api_key) { '' }

        it 'response is 401' do
          expect(last_response.status).to eq(401)
        end
      end

      context 'invalid data' do
        let(:post_data) { 'abc' }
        it 'response status is 400' do
          expect(last_response.status).to eq(400)
        end
        it 'error message' do
          expect(last_response.body).to include('Bad request. Should be an array')
        end
      end
    end
  end

  context 'GET to /order/:id' do
    let(:attributes) { json_data(filename: 'orders').first }
    let!(:order) { Order.create!(attributes) }
    let(:response) { get "/orders/#{order.id}", nil, headers }

    context 'valid params' do
      it 'returns status 200' do
        expect(response.status).to eq 200
      end
      it 'returns order object' do
        expect(response.body).to eq order.attributes.to_json
      end
    end

    context 'invalid params' do
      context 'invalid api-key' do
        let(:api_key) { '' }
        it 'returns status 401' do
          expect(response.status).to eq 401
        end
      end
      context 'id not found' do
        it 'returns status 401' do
          expect(response.status).to eq 200
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
