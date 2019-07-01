class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price, :merchant_id
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices

  attribute :unit_price do |object|
    object.unit_price = ('%.2f' % (object.unit_price.to_f/100))
  end
end
