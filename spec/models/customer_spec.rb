require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'instance methods' do
    before :each do
      @c1 = create(:customer)
      @c2 = create(:customer)
      @m1 = create(:merchant)
      @m2 = create(:merchant)
      @m3 = create(:merchant)
      @invoice1 = create(:invoice, merchant: @m1, customer: @c2, updated_at: "2012-03-25 09:54:09 UTC")
      @invoice2 = create(:invoice, merchant: @m2, customer: @c2, updated_at: "2012-03-24 09:54:09 UTC")
      @invoice3 = create(:invoice, merchant: @m3, customer: @c1, updated_at: "2012-03-24 09:54:09 UTC")
      @t1 = create(:transaction, invoice: @invoice1, result: "success")
      @t2 = create(:transaction, invoice: @invoice2, result: "success")
      @t3 = create(:transaction, invoice: @invoice3, result: "success")
      @t3 = create(:transaction, invoice: @invoice1, result: "success")
      @t3 = create(:transaction, invoice: @invoice1, result: "success")
      @t3 = create(:transaction, invoice: @invoice2, result: "success")
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

    it '.favorite_merchant' do
      transactions = @c2.favorite_merchant.trx_count

      expect(@c2.favorite_merchant).to eq(@m1)
      expect(transactions).to eq(3)
    end
  end
end
