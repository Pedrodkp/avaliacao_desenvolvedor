json.extract! sale, :id, :customer, :description, :price, :amount, :address, :furnisher, :source_file, :created_at, :updated_at
json.url sale_url(sale, format: :json)