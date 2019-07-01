class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    Merchant.joins(:invoices, :transactions)
    .select('merchants.*, COUNT(transactions.id) AS trx_count')
    .where('invoices.customer' => self.id, 'transactions.result' => 'success')
    .group(:id)
    .order('trx_count DESC')
    .first
  end
end
