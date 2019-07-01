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

  # def self.total_revenue_by_date(date)
  #   require "pry"; binding.pry
  #   Invoice.joins(:invoice_items, :transactions)
  #   .where(updated_at: date)
  #   .sum('invoice_items.quantity * invoice_items.unit_price')
  # end

  def revenue
    Invoice.joins(:invoice_items, :transactions)
    .where(merchant: self.id, 'transactions.result' => 'success')
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

end
