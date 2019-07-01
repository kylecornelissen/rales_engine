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

## Relationship Endpoints:
### Merchants
- GET /api/v1/merchants/:id/items
  - returns a collection of items associated with that merchant
- GET /api/v1/merchants/:id/invoices
  - returns a collection of invoices associated with that merchant from their known orders
### Customers
- GET /api/v1/customers/:id/invoices
  - returns a collection of associated invoices
- GET /api/v1/customers/:id/transactions 
  - returns a collection of associated transactions
### Invoices
- GET /api/v1/invoices/:id/transactions 
  - returns a collection of associated transactions
- GET /api/v1/invoices/:id/invoice_items 
  - returns a collection of associated invoice items
- GET /api/v1/invoices/:id/items 
  - returns a collection of associated items
- GET /api/v1/invoices/:id/customer 
  - returns the associated customer
- GET /api/v1/invoices/:id/merchant 
  - returns the associated merchant
### Invoice Items
- GET /api/v1/invoice_items/:id/invoice 
  - returns the associated invoice
- GET /api/v1/invoice_items/:id/item 
  - returns the associated item
### Items
- GET /api/v1/items/:id/invoice_items
  - returns a collection of associated invoice items
- GET /api/v1/items/:id/merchant 
  - returns the associated merchant
### Transactions
- GET /api/v1/transactions/:id/invoice 
  - returns the associated invoice

## Business Intelligence Endpoints:
### All Merchants
- GET /api/v1/merchants/most_revenue?quantity=x 
  - returns the top x merchants ranked by total revenue
- GET /api/v1/merchants/most_items?quantity=x 
  - returns the top x merchants ranked by total number of items sold
### Single Merchant
- GET /api/v1/merchants/:id/revenue 
  - returns the total revenue for that merchant across successful transactions
- GET /api/v1/merchants/:id/favorite_customer 
  - returns the customer who has conducted the most total number of successful transactions.
### Items
- GET /api/v1/items/most_revenue?quantity=x 
  - returns the top x items ranked by total revenue generated
- GET /api/v1/items/most_items?quantity=x 
  - returns the top x item instances ranked by total number sold
### Customers
- GET /api/v1/customers/:id/favorite_merchant 
  - returns a merchant where the customer has conducted the most successful transactions
