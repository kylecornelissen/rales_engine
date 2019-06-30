require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    m1 = create(:merchant)
    create_list(:item, 3, merchant: m1)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]
    expect(items.count).to eq(3)
  end

  it "can get one item by its id" do
    m1 = create(:merchant)
    id = create(:item, merchant: m1).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item["id"].to_i).to eq(id)
    item = [item]
    expect(item.count).to eq(1)
  end

  it "can get one item by given parameter" do
    m1 = create(:merchant)
    i1 = create(:item, name: "car", merchant: m1)
    i2 = create(:item, name: "book", merchant: m1)
    i3 = create(:item, name: "book", merchant: m1)

    get "/api/v1/items/find?name=car"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item["attributes"]["name"]).to eq("car")
    item = [item]
    expect(item.count).to eq(1)
  end

  it "can get all items by given parameter" do
    m1 = create(:merchant)
    i1 = create(:item, name: "car", merchant: m1)
    i2 = create(:item, name: "book", merchant: m1)
    i3 = create(:item, name: "book", merchant: m1)

    get "/api/v1/items/find_all?name=book"

    items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(items.count).to eq(2)
  end

  it "can get a random item" do
    i1 = create_list(:item, 3)

    get "/api/v1/items/random"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    item = [item]
    expect(item.count).to eq(1)
  end
end
