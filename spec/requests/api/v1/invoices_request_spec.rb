require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    c1 = create(:customer)
    m1 = create(:merchant)
    create_list(:invoice, 3, merchant: m1, customer: c1)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]
    expect(invoices.count).to eq(3)
  end

  it "can get one invoice by its id" do
    c1 = create(:customer)
    m1 = create(:merchant)
    id = create(:invoice, merchant: m1, customer: c1).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(id)
    invoice = [invoice]
    expect(invoice.count).to eq(1)
  end

  it "can get one invoice by given parameter" do
    c1 = create(:customer)
    m1 = create(:merchant)
    i1 = create(:invoice, status: "shipped", merchant: m1, customer: c1)
    i2 = create(:invoice, status: "shipped", merchant: m1, customer: c1)
    i3 = create(:invoice, status: "not shipped", merchant: m1, customer: c1)

    get "/api/v1/invoices/find?status=shipped"

    invoice = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice["attributes"]["status"]).to eq("shipped")
    invoice = [invoice]
    expect(invoice.count).to eq(1)
  end

  it "can get all invoices by given parameter" do
    c1 = create(:customer)
    m1 = create(:merchant)
    i1 = create(:invoice, status: "shipped", merchant: m1, customer: c1)
    i2 = create(:invoice, status: "shipped", merchant: m1, customer: c1)
    i3 = create(:invoice, status: "not shipped", merchant: m1, customer: c1)

    get "/api/v1/invoices/find_all?status=shipped"

    invoices = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoices.count).to eq(2)
  end

  it "can get a random invoice" do
    i1 = create_list(:invoice, 3)

    get "/api/v1/invoices/random"

    invoice = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    invoice = [invoice]
    expect(invoice.count).to eq(1)
  end

  it "can get all invoice transactions" do
    i1 = create(:invoice)
    t_list = create_list(:transaction, 5, invoice: i1)
    t6 = create(:transaction)

    get "/api/v1/invoices/#{i1.id}/transactions"

    transactions = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transactions.count).to eq(5)
  end

  it "can get all invoice invoice_items" do
    i1 = create(:invoice)
    ii_list = create_list(:invoice_item, 4, invoice: i1)
    i5 = create(:invoice_item)

    get "/api/v1/invoices/#{i1.id}/invoice_items"

    invoice_items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_items.count).to eq(4)
  end

  it "can get all invoice items" do
    i1 = create(:invoice)
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    item4 = create(:item)
    ii1 = create(:invoice_item, invoice: i1, item: item1)
    ii2 = create(:invoice_item, invoice: i1, item: item2)
    ii3 = create(:invoice_item, invoice: i1, item: item3)

    get "/api/v1/invoices/#{i1.id}/items"

    items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(items.count).to eq(3)
  end

  it "can get invoice customer" do
    c1 = create(:customer, first_name: "alan")
    i1 = create(:invoice, customer: c1)

    get "/api/v1/invoices/#{i1.id}/customer"

    customer = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer["attributes"]["first_name"]).to eq("alan")
    customer = [customer]
    expect(customer.count).to eq(1)
  end

  it "can get invoice customer" do
    m1 = create(:merchant, name: "betty")
    i1 = create(:invoice, merchant: m1)

    get "/api/v1/invoices/#{i1.id}/merchant"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["attributes"]["name"]).to eq("betty")
    merchant = [merchant]
    expect(merchant.count).to eq(1)
  end
end
