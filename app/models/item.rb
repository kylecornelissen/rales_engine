class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.most_revenue(quantity)
    select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoice_items, :transactions)
    .where('transactions.result' => 'success')
    .group(:id)
    .order('revenue DESC')
    .limit(quantity)
  end

  def self.most_quantity_sold(quantity)
    select('items.*, SUM(invoice_items.quantity) AS total_quantity')
    .joins(:invoice_items, :transactions)
    .where('transactions.result' => 'success')
    .group(:id)
    .order('total_quantity DESC')
    .limit(quantity)
  end
end
