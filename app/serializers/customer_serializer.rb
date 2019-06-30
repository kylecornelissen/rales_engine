class CustomerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name
  has_many :invoices
  has_many :invoice_items
end
