require 'csv'

namespace :import_invoice_item do
  desc "import invoice items from CSV file"

  task invoice_item: :environment do
    CSV.foreach('./data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create(row.to_h)
    end
  end

end
