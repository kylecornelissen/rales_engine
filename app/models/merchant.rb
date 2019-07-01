class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices

  def self.most_revenue(limit_num)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(invoices: [:invoice_items, :transactions])
    .where('transactions.result' => 'success')
    .group(:id)
    .order('revenue DESC')
    .limit(limit_num)
  end
end
