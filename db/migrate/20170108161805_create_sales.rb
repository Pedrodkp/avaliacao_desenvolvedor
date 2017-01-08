class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :customer
      t.string :description
      t.decimal :price
      t.decimal :amount
      t.string :address
      t.string :furnisher
      t.string :source_file

      t.timestamps null: false
    end
  end
end
