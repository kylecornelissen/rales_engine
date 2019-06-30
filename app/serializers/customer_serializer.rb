class CustomerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :first_name, :last_name
  has_many :invoices
  has_many :invoice_items
end
