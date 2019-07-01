require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:invoices) }
  end

  describe 'class methods' do
    before :each do
      @m1 = create(:merchant)
      @m2 = create(:merchant)
      @m3 = create(:merchant)
      @invoice1 = create(:invoice, merchant: @m1, updated_at: "2012-03-25 09:54:09 UTC")
      @invoice2 = create(:invoice, merchant: @m2, updated_at: "2012-03-24 09:54:09 UTC")
      @invoice3 = create(:invoice, merchant: @m3, updated_at: "2012-03-24 09:54:09 UTC")
      @t1 = create(:transaction, invoice: @invoice1, result: "success")
      @t2 = create(:transaction, invoice: @invoice2, result: "success")
      @t3 = create(:transaction, invoice: @invoice3, result: "success")
      @item1 = create(:item, merchant: @m1)
      @item2 = create(:item, merchant: @m1)
      @item3 = create(:item, merchant: @m1)
      @item4 = create(:item, merchant: @m2)
      @item5 = create(:item, merchant: @m2)
      @item6 = create(:item, merchant: @m2)
      @item7 = create(:item, merchant: @m3)
      @item8 = create(:item, merchant: @m3)
      @item9 = create(:item, merchant: @m3)
      @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, unit_price: 10, quantity: 3)
      @inv_item2 = create(:invoice_item, invoice: @invoice1, item: @item2, unit_price: 15, quantity: 2)
      @inv_item3 = create(:invoice_item, invoice: @invoice1, item: @item3, unit_price: 20, quantity: 1)
      @inv_item4 = create(:invoice_item, invoice: @invoice2, item: @item4, unit_price: 100, quantity: 3)
      @inv_item5 = create(:invoice_item, invoice: @invoice2, item: @item5, unit_price: 150, quantity: 2)
      @inv_item6 = create(:invoice_item, invoice: @invoice2, item: @item6, unit_price: 200, quantity: 2)
      @inv_item7 = create(:invoice_item, invoice: @invoice3, item: @item7, unit_price: 1, quantity: 3)
      @inv_item8 = create(:invoice_item, invoice: @invoice3, item: @item8, unit_price: 2, quantity: 2)
      @inv_item9 = create(:invoice_item, invoice: @invoice3, item: @item9, unit_price: 3, quantity: 8)
    end

    it '.most_revenue' do
      merchants = Merchant.all
      revenue = merchants.most_revenue(2).map { |merchant| merchant.revenue }

      expect(merchants.most_revenue(2)).to eq([@m2, @m1])
      expect(revenue).to eq([1000, 80])
    end

    it '.most_items' do
      merchants = Merchant.all
      total_items_sold = merchants.most_items(2).map { |merchant| merchant.total_items }

      expect(merchants.most_items(2)).to eq([@m3, @m2])
      expect(total_items_sold).to eq([13, 7])
    end

    # it '.total_revenue_by_date' do
    #   merchants = Merchant.all
    #
    #   expect(merchants.total_revenue_by_date("2012-03-24 09:54:09 UTC +00:00")).to eq(1031)
    # end
  end

  describe 'instance methods' do
    before :each do
      @c1 = create(:customer)
      @c2 = create(:customer)
      @m1 = create(:merchant)
      @m2 = create(:merchant)
      @m3 = create(:merchant)
      @invoice1 = create(:invoice, merchant: @m1, customer: @c2, updated_at: "2012-03-25 09:54:09 UTC")
      @invoice2 = create(:invoice, merchant: @m2, updated_at: "2012-03-24 09:54:09 UTC")
      @invoice3 = create(:invoice, merchant: @m3, updated_at: "2012-03-24 09:54:09 UTC")
      @t1 = create(:transaction, invoice: @invoice1, result: "success")
      @t2 = create(:transaction, invoice: @invoice2, result: "success")
      @t3 = create(:transaction, invoice: @invoice3, result: "success")
      @item1 = create(:item, merchant: @m1)
      @item2 = create(:item, merchant: @m1)
      @item3 = create(:item, merchant: @m1)
      @item4 = create(:item, merchant: @m2)
      @item5 = create(:item, merchant: @m2)
      @item6 = create(:item, merchant: @m2)
      @item7 = create(:item, merchant: @m3)
      @item8 = create(:item, merchant: @m3)
      @item9 = create(:item, merchant: @m3)
      @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, unit_price: 10, quantity: 3)
      @inv_item2 = create(:invoice_item, invoice: @invoice1, item: @item2, unit_price: 15, quantity: 2)
      @inv_item3 = create(:invoice_item, invoice: @invoice1, item: @item3, unit_price: 20, quantity: 1)
      @inv_item4 = create(:invoice_item, invoice: @invoice2, item: @item4, unit_price: 100, quantity: 3)
      @inv_item5 = create(:invoice_item, invoice: @invoice2, item: @item5, unit_price: 150, quantity: 2)
      @inv_item6 = create(:invoice_item, invoice: @invoice2, item: @item6, unit_price: 200, quantity: 2)
      @inv_item7 = create(:invoice_item, invoice: @invoice3, item: @item7, unit_price: 1, quantity: 3)
      @inv_item8 = create(:invoice_item, invoice: @invoice3, item: @item8, unit_price: 2, quantity: 2)
      @inv_item9 = create(:invoice_item, invoice: @invoice3, item: @item9, unit_price: 3, quantity: 8)
    end

    it '.revenue' do
      expect(@m1.revenue).to eq(80)
    end

    it '.favorite_customer' do
      invoice4 = create(:invoice, merchant: @m1, customer: @c1)
      t4 = create(:transaction, invoice: @invoice1, result: "success")
      t5 = create(:transaction, invoice: invoice4, result: "success")

      transactions = @m1.favorite_customer.trx_count

      expect(@m1.favorite_customer).to eq(@c2)
      expect(transactions).to eq(2)
    end
  end
end
