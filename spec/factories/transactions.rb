FactoryBot.define do
  factory :transaction do
    transaction_number { "MyString" }
    invoice { create(:invoice) }
    credit_card_number { "MyString" }
    credit_card_expiration_date { "2019-06-29 17:07:13" }
    result { "MyString" }
  end
end
