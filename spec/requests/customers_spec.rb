# frozen_string_literal: true

require 'spec_helper'
# rubocop:disable Metrics/BlockLength
describe Customer do
  let(:api_key) { 'put_here_an_api_key' }
  let(:headers) { { 'Accept' => 'application/json', 'HTTP_X_API_KEY' => api_key } }

  context 'GET to /customers' do
    let(:response) { get '/customers', nil, headers }
    let(:attributes) { json_data(filename: 'customers') }
    let!(:customers) { Customer.create!(attributes) }

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
      it 'returns an array of customers' do
        expect(response.body).to include(customers.to_json)
      end
    end
  end

  context 'POST to /customers' do
    let(:api_key) { 'put_here_an_api_key' }
    let(:request) { post '/customers', post_data.to_json, headers }
    let(:post_data) { json_data(filename: 'customers') }

    context 'valid params' do
      it 'shows response ok and valid type' do
        expect { request }.to change(Customer, :count).by(2)
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

  context 'GET to /customer/:id' do
    let(:attributes) { json_data(filename: 'customers').first }
    let!(:customer) { Customer.create!(attributes) }
    let(:response) { get "/customers/#{customer.id}", nil, headers }

    context 'valid params' do
      it 'returns status 200' do
        expect(response.status).to eq 200
      end
      it 'returns customer object' do
        expect(response.body).to eq customer.attributes.to_json
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
