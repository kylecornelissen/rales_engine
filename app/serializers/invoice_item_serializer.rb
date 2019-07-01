class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :quantity, :unit_price, :invoice_id, :item_id
  belongs_to :item
  belongs_to :invoice
end
