class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.string :merchant_number
      t.string :name

      t.timestamps
    end
  end
end
