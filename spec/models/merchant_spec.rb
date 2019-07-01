require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:invoices) }
  end

  describe 'class methods' do
    it '.most_revenue' do
      m1 = create(:merchant)
      m2 = create(:merchant)
      m3 = create(:merchant)
      invoice1 = create(:invoice, merchant: m1)
      invoice2 = create(:invoice, merchant: m2)
      invoice3 = create(:invoice, merchant: m3)
      t1 = create(:transaction, invoice: invoice1, result: "success")
      t2 = create(:transaction, invoice: invoice2, result: "success")
      t3 = create(:transaction, invoice: invoice3, result: "success")
      item1 = create(:item, merchant: m1)
      item2 = create(:item, merchant: m1)
      item3 = create(:item, merchant: m1)
      item4 = create(:item, merchant: m2)
      item5 = create(:item, merchant: m2)
      item6 = create(:item, merchant: m2)
      item7 = create(:item, merchant: m3)
      item8 = create(:item, merchant: m3)
      item9 = create(:item, merchant: m3)
      inv_item1 = create(:invoice_item, invoice: invoice1, item: item1, unit_price: 10, quantity: 3)
      inv_item2 = create(:invoice_item, invoice: invoice1, item: item2, unit_price: 15, quantity: 2)
      inv_item3 = create(:invoice_item, invoice: invoice1, item: item3, unit_price: 20, quantity: 1)
      inv_item4 = create(:invoice_item, invoice: invoice2, item: item4, unit_price: 100, quantity: 3)
      inv_item5 = create(:invoice_item, invoice: invoice2, item: item5, unit_price: 150, quantity: 2)
      inv_item6 = create(:invoice_item, invoice: invoice2, item: item6, unit_price: 200, quantity: 1)
      inv_item7 = create(:invoice_item, invoice: invoice3, item: item7, unit_price: 1, quantity: 3)
      inv_item8 = create(:invoice_item, invoice: invoice3, item: item8, unit_price: 2, quantity: 2)
      inv_item9 = create(:invoice_item, invoice: invoice3, item: item9, unit_price: 3, quantity: 1)

      merchants = Merchant.all
      revenue = merchants.most_revenue(2).map { |merchant| merchant.revenue }
      expect(merchants.most_revenue(2)).to eq([m2, m1])
      expect(revenue).to eq([800, 80])
    end
  end
end
