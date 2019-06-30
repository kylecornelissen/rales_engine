FactoryBot.define do
  factory :invoice do
    invoice_number { "MyString" }
    customer { nil }
    merchant { nil }
    status { "MyString" }
  end
end
