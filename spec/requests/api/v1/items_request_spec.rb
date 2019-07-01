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

  it "can get all item invoice_items" do
    item1 = create(:item)
    ii_list = create_list(:invoice_item, 4, item: item1)
    ii5 = create(:invoice_item)

    get "/api/v1/items/#{item1.id}/invoice_items"

    invoice_items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_items.count).to eq(4)
  end

  it "can get item merchant" do
    m1 = create(:merchant, name: "alan")
    i1 = create(:item, merchant: m1)

    get "/api/v1/items/#{i1.id}/merchant"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["attributes"]["name"]).to eq("alan")
    merchant = [merchant]
    expect(merchant.count).to eq(1)
  end
end
describe "Business Intel endpoints" do
  before :each do
    @m1 = create(:merchant)
    @m2 = create(:merchant)
    @m3 = create(:merchant)
    @invoice1 = create(:invoice, merchant: @m1)
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
    @inv_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, unit_price: 10, quantity: 1)
    @inv_item2 = create(:invoice_item, invoice: @invoice1, item: @item2, unit_price: 15, quantity: 1)
    @inv_item3 = create(:invoice_item, invoice: @invoice1, item: @item3, unit_price: 20, quantity: 1)
    @inv_item4 = create(:invoice_item, invoice: @invoice2, item: @item4, unit_price: 100, quantity: 2)
    @inv_item5 = create(:invoice_item, invoice: @invoice2, item: @item5, unit_price: 150, quantity: 2)
    @inv_item6 = create(:invoice_item, invoice: @invoice2, item: @item6, unit_price: 200, quantity: 4)
    @inv_item7 = create(:invoice_item, invoice: @invoice3, item: @item7, unit_price: 1, quantity: 7)
    @inv_item8 = create(:invoice_item, invoice: @invoice3, item: @item8, unit_price: 2, quantity: 5)
    @inv_item9 = create(:invoice_item, invoice: @invoice3, item: @item9, unit_price: 3, quantity: 8)
  end

  it 'can get top items by most revenue given limit parameter' do
    get "/api/v1/items/most_revenue?quantity=5"

    items = JSON.parse(response.body)["data"]
    top_items = items.map { |item| item["attributes"]["id"] }

    expect(response).to be_successful
    expect(top_items).to eq([@item6.id, @item5.id, @item4.id, @item9.id, @item3.id])
    expect(items.count).to eq(5)
  end

  it 'can get top items by most quantity sold given limit parameter' do
    get "/api/v1/items/most_items?quantity=4"

    items = JSON.parse(response.body)["data"]
    top_items = items.map { |item| item["attributes"]["id"] }

    expect(response).to be_successful
    expect(top_items).to eq([@item9.id, @item7.id, @item8.id, @item6.id])
    expect(items.count).to eq(4)
  end
end
