FactoryBot.define do
  factory :invoice_item do
    invoice_item_number { "MyString" }
    item { create(:item) }
    invoice { create(:invoice) }
    quantity { 1 }
    unit_price { 1 }
  end
end
