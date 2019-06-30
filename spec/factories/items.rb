FactoryBot.define do
  factory :item do
    item_number { "MyString" }
    name { "MyString" }
    description { "MyString" }
    unit_price { 1 }
    merchant { create(:merchant) }
  end
end
