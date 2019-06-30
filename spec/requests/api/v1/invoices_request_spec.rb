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
end
