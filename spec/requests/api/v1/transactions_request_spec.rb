require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)["data"]
    expect(transactions.count).to eq(3)
  end

  it "can get one transaction by its id" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction["id"].to_i).to eq(id)
    transaction = [transaction]
    expect(transaction.count).to eq(1)
  end

  it "can get one transaction by given parameter" do
    i1 = create(:transaction, result: "success")
    i2 = create(:transaction, result: "failure")
    i3 = create(:transaction, result: "failure")

    get "/api/v1/transactions/find?result=success"

    transaction = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction["attributes"]["result"]).to eq("success")
    transaction = [transaction]
    expect(transaction.count).to eq(1)
  end

  it "can get all transactions by given parameter" do
    i1 = create(:transaction, result: "success")
    i2 = create(:transaction, result: "failure")
    i3 = create(:transaction, result: "failure")

    get "/api/v1/transactions/find_all?result=failure"

    transactions = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transactions.count).to eq(2)
  end

  it "can get a random transaction" do
    t1 = create_list(:transaction, 3)

    get "/api/v1/transactions/random"

    transaction = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    transaction = [transaction]
    expect(transaction.count).to eq(1)
  end
end
