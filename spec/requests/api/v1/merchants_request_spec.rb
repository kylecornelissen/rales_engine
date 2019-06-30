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
