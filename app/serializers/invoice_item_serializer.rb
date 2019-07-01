class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :quantity, :unit_price, :invoice_id, :item_id
  belongs_to :item
  belongs_to :invoice

  attribute :unit_price do |object|
    object.unit_price = ('%.2f' % (object.unit_price.to_f/100))
  end
end
