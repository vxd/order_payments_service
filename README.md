# sinatra_customers_management_api
This project is an API for managing a customer database. It has been developed using Ruby Sinatra and PostgreSQL

## Features
* API Key Authentication.
* Creating new customers through a JSON API.
* Viewing customer details by ID.
* Paginated listing of customers with the ability to specify the number of items per page.
## Technologies
* Ruby
* Sinatra
* PostgreSQL
* Docker
## Installation
### Clone the repository to your local machine:
```
git clone https://github.com/vxd/order_payments_service.git
cd order_payments_service
```
## Running the Application

### Running the Application Locally (without Docker)

1. Install all necessary gems:
```
bundle install
```
2. Set up a .env file with the appropriate values derived from .env.example
3. Create database:
```
bundle exec rake db:create
```
4. Run the database migration:
```
bundle exec rake db:migrate
```
5. Test the app:
```
bundle exec rspec
```
6. Run the app:
```
bundle exec rackup -o 0.0.0.0 -p 4567
```

### Running the Application using Docker
1. Install Docker and Docker Compose. Ruby should be installed on your machine.
2. Build and run the application using Docker Compose:
```
docker-compose up
```

The application will be accessible at http://localhost:4567.

## Working with the API
Use an HTTP client such as curl or Postman to interact with the API.

## Request Examples:
1. Create new customers:
```
curl -X POST -H "Content-Type: application/json" -H "X-Api-Key: your_api_key" -d '[{"first_name": "John", last_name: "Doe", patronymic_name: "David", "email": "john.doe@example.com"}, {"first_name": "Jane", last_name: "Doe", patronymic_name: "Steven", "email": "jane.doe@example.com"}]' http://localhost:4567/customers
```
2. Get a list of all customers:
```
curl -X GET -H "X-Api-Key: your_api_key" http://localhost:4567/customers
```
you also can set page and per_page query parameters:
```
curl -X GET -H "X-Api-Key: your_api_key" http://localhost:4567/customers?page=1&per_page=5
```

3. Get customer information by ID:
```
curl -X GET -H "X-Api-Key: your_api_key" http://localhost:4567/customers/1
```


4. Create new order:
```
curl -X POST -H "Content-Type: application/json" -H "X-Api-Key: your_api_key" -d '[{"total": 1000, "user_id": 1 }, {"total": 2000, "user_id": 1 }]' http://localhost:4567/orders
```
2. Get a list of all order:
```
curl -X GET -H "X-Api-Key: your_api_key" http://localhost:4567/orders
```
you also can set page and per_page query parameters:
```
curl -X GET -H "X-Api-Key: your_api_key" http://localhost:4567/orders?page=1&per_page=1
```

3. Get order information by ID:
```
curl -X GET -H "X-Api-Key: your_api_key" http://localhost:4567/orders/1
```

