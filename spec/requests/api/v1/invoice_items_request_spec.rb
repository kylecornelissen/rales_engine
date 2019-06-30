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
  end

  it "can get one invoice item by given parameter" do
    ii1 = create(:invoice_item, quantity: 5)
    ii2 = create(:invoice_item, quantity: 5)
    ii3 = create(:invoice_item, quantity: 8)

    get "/api/v1/invoice_items/find?quantity=5"

    invoice_item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item["attributes"]["quantity"]).to eq(5)
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
end
