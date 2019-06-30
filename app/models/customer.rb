class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
end
