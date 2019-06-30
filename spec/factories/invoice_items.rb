FactoryBot.define do
  factory :invoice_item do
    invoice_item_number { "MyString" }
    item { nil }
    invoice { nil }
    quantity { 1 }
    unit_price { 1 }
  end
end
