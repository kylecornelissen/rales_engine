# Rales Engine
In this project, I used Rails and ActiveRecord to build a JSON API which exposes the SalesEngine data schema.

## System Requirements:
* Ruby version: 5.1.7
* PostgreSQL
* Ruby 2.4.1

## Gems Used
* RSpec-rails
* Capybara
* Factory_bot_rails
* Selenium-webdriver
* Shoulda-matchers
* Simplecov
* Pry
* Fast_jsonapi
* Faker

## Importing the CSV files
- run 'rake import:seed' in your terminal command line

## Opening up the app in browser
- run 'rails s' in your terminal command line
- go to your browser and connect to your local host (localhost:3000 by default)

## Database Tables and Attributes
- merchants (id, name)
- customers (id, first_name, last_name)
- items (id, name, description, unit_price, merchant_id)
- invoices (id, status, customer_id, merchant_id)
- invoice_items (id, quantity, unit_price, invoice_id, item_id)
- transactions (id, credit_card_number, result, invoice_id)

## Record Endpoints:
### Find Records Index and Individual Record Show Pages
- GET /api/v1/[database_table]
- GET /api/v1/[database_table]/[id]

### Single and Multi-Finders
- GET /api/v1/[database_table]/find?[attribute_name]=[attribute_value]
- GET /api/v1/[database_table]/find_all?[attribute_name]=[attribute_value]

### Random Record
- GET /api/v1/[database_table]/random

