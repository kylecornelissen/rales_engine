class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices
end
