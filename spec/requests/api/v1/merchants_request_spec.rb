require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)["data"]
    expect(merchants.count).to eq(3)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["id"].to_i).to eq(id)
    merchant = [merchant]
    expect(merchant.count).to eq(1)
  end

  it "can get one merchant by given parameter" do
    m1 = create(:merchant, name: "bob")
    m2 = create(:merchant, name: "sally")
    m3 = create(:merchant, name: "sally")

    get "/api/v1/merchants/find?name=bob"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["attributes"]["name"]).to eq("bob")
    merchant = [merchant]
    expect(merchant.count).to eq(1)
  end

  it "can get all merchants by given parameter" do
    m1 = create(:merchant, name: "bob")
    m2 = create(:merchant, name: "sally")
    m3 = create(:merchant, name: "sally")

    get "/api/v1/merchants/find_all?name=sally"

    merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchants.count).to eq(2)
  end

  it "can get a random merchant" do
    m1 = create_list(:merchant, 3)

    get "/api/v1/merchants/random"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    merchant = [merchant]
    expect(merchant.count).to eq(1)
  end

  it "can get all merchant items" do
    m1 = create(:merchant)
    i = create_list(:item, 5, merchant: m1)
    i6 = create(:item)

    get "/api/v1/merchants/#{m1.id}/items"

    items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(items.count).to eq(5)
  end

  it "can get all merchant invoices" do
    m1 = create(:merchant)
    i = create_list(:invoice, 4, merchant: m1)
    i5 = create(:invoice)

    get "/api/v1/merchants/#{m1.id}/invoices"

    invoices = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoices.count).to eq(4)
  end
end

describe "Business Intel endpoints" do
  before :each do
    @c1 = create(:customer)
    @c2 = create(:customer)
    @m1 = create(:merchant)
    @m2 = create(:merchant)
    @m3 = create(:merchant)
    @invoice1 = create(:invoice, merchant: @m1, customer: @c1)
    @invoice2 = create(:invoice, merchant: @m2)
    @invoice3 = create(:invoice, merchant: @m3)
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
    @inv_item6 = create(:invoice_item, invoice: @invoice2, item: @item6, unit_price: 200, quantity: 1)
    @inv_item7 = create(:invoice_item, invoice: @invoice3, item: @item7, unit_price: 1, quantity: 3)
    @inv_item8 = create(:invoice_item, invoice: @invoice3, item: @item8, unit_price: 2, quantity: 2)
    @inv_item9 = create(:invoice_item, invoice: @invoice3, item: @item9, unit_price: 3, quantity: 1)
  end

  it 'can get top merchants by most revenue given limit parameter' do
    get "/api/v1/merchants/most_revenue?quantity=3"

    merchants = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end

  it 'can get top merchants by most items sold given limit parameter' do
    get "/api/v1/merchants/most_items?quantity=2"

    merchants = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(merchants.count).to eq(2)
  end

  it 'can get merchant revenue' do
    get "/api/v1/merchants/#{@m1.id}/revenue"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["attributes"]["revenue"]).to eq("0.80")
  end

  it 'can get merchant favorite customer with most transactions' do
    invoice4 = create(:invoice, merchant: @m1, customer: @c2)
    t4 = create(:transaction, invoice: @invoice1, result: "success")
    t5 = create(:transaction, invoice: invoice4, result: "success")

    get "/api/v1/merchants/#{@m1.id}/favorite_customer"

    customer = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer["id"].to_i).to eq(@c1.id)
  end
end
