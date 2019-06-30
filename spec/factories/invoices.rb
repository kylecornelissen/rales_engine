FactoryBot.define do
  factory :invoice do
    invoice_number { "MyString" }
    customer { create(:customer) }
    merchant { create(:merchant) }
    status { "MyString" }
  end
end
