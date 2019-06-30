require 'rails_helper'

describe "InvoiceItems API" do
  it "sends a list of invoice items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)["data"]

    expect(invoice_items.count).to eq(3)
  end

  it "can get one invoice item by its id" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item["id"].to_i).to eq(id)
    invoice_item = [invoice_item]
    expect(invoice_item.count).to eq(1)
  end

  it "can get one invoice item by given parameter" do
    ii1 = create(:invoice_item, quantity: 5)
    ii2 = create(:invoice_item, quantity: 5)
    ii3 = create(:invoice_item, quantity: 8)

    get "/api/v1/invoice_items/find?quantity=5"

    invoice_item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item["attributes"]["quantity"]).to eq(5)
    invoice_item = [invoice_item]
    expect(invoice_item.count).to eq(1)
  end

  it "can get all invoice items by given parameter" do
    ii1 = create(:invoice_item, quantity: 5)
    ii2 = create(:invoice_item, quantity: 5)
    ii3 = create(:invoice_item, quantity: 8)

    get "/api/v1/invoice_items/find_all?quantity=5"

    invoice_items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_items.count).to eq(2)
  end

  it "can get a random invoice item" do
    ii1 = create_list(:invoice_item, 3)

    get "/api/v1/invoice_items/random"

    invoice_item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    invoice_item = [invoice_item]
    expect(invoice_item.count).to eq(1)
  end

  it "can get invoice_item invoice" do
    i1 = create(:invoice, status: "test")
    ii1 = create(:invoice_item, invoice: i1)

    get "/api/v1/invoice_items/#{ii1.id}/invoice"

    invoice = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice["attributes"]["status"]).to eq("test")
    invoice = [invoice]
    expect(invoice.count).to eq(1)
  end

  it "can get invoice_item item" do
    item1 = create(:item, name: "book")
    ii1 = create(:invoice_item, item: item1)

    get "/api/v1/invoice_items/#{ii1.id}/item"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item["attributes"]["name"]).to eq("book")
    item = [item]
    expect(item.count).to eq(1)
  end
end
