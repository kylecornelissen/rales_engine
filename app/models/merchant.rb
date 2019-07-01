class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices

  def self.most_revenue(quantity)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(invoices: [:invoice_items, :transactions])
    .where('transactions.result' => 'success')
    .group(:id)
    .order('revenue DESC')
    .limit(quantity)
  end

  def self.most_items(quantity)
    select('merchants.*, SUM(invoice_items.quantity) AS total_items')
    .joins(invoices: [:invoice_items, :transactions])
    .where('transactions.result' => 'success')
    .group(:id)
    .order('total_items DESC')
    .limit(quantity)
  end
end
