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
end
