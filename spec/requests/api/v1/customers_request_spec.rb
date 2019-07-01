require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)["data"]
    expect(customers.count).to eq(3)
  end

  it "can get one customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer["id"].to_i).to eq(id)
    customer = [customer]
    expect(customer.count).to eq(1)
  end

  it "can get one customer by given parameter" do
    m1 = create(:customer, first_name: "bob")
    m2 = create(:customer, first_name: "sally")
    m3 = create(:customer, first_name: "sally")

    get "/api/v1/customers/find?first_name=bob"

    customer = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer["attributes"]["first_name"]).to eq("bob")
    customer = [customer]
    expect(customer.count).to eq(1)
  end

  it "can get all customers by given parameter" do
    m1 = create(:customer, first_name: "bob")
    m2 = create(:customer, first_name: "sally")
    m3 = create(:customer, first_name: "sally")

    get "/api/v1/customers/find_all?first_name=sally"

    customers = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customers.count).to eq(2)
  end

  it "can get a random customer" do
    c1 = create_list(:customer, 3)

    get "/api/v1/customers/random"

    customer = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    customer = [customer]
    expect(customer.count).to eq(1)
  end

  it "can get customer invoices" do
    c1 = create(:customer)
    i_list = create_list(:invoice, 5, customer: c1)
    i6 = create(:invoice)

    get "/api/v1/customers/#{c1.id}/invoices"

    invoices = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoices.count).to eq(5)
  end

  it "can get customer transactions" do
    c1 = create(:customer)
    i1 = create(:invoice, customer: c1)
    t_list = create_list(:transaction, 4, invoice: i1)

    get "/api/v1/customers/#{c1.id}/transactions"

    transactions = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transactions.count).to eq(4)
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

  it 'can get customer favorite merchant with most transactions' do
    invoice4 = create(:invoice, merchant: @m1, customer: @c2)
    t4 = create(:transaction, invoice: @invoice1, result: "success")
    t5 = create(:transaction, invoice: invoice4, result: "success")

    get "/api/v1/customers/#{@c1.id}/favorite_merchant"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["id"].to_i).to eq(@m1.id)
  end
end
