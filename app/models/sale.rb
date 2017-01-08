class Sale < ActiveRecord::Base
  def self.import(file)
    # file example:
    #
    # Comprador descrição Preço Unitário  Quantidade  Endereço  Fornecedor
    # João Silva  R$10 off R$20 of food 10.0  2 987 Fake St Bob's Pizza
    # Amy Pond  R$30 of awesome for R$10  10.0  5 456 Unreal Rd Tom's Awesome Shop
    # Marty McFly R$20 Sneakers for R$5 5.0 1 123 Fake St Sneaker Store Emporium
    # Snake Plissken  R$20 Sneakers for R$5 5,2 4 123 Fake St Sneaker Store Emporium

    if file != nil
      Sale.where(source_file: file.original_filename).destroy_all

      CSV.foreach(file.path, headers: true, :col_sep => "\t") do |row|      
        Sale.create!(customer: row[0],
                     description: row[1],
                     price: row[2],
                     amount: row[3],
                     address: row[4],
                     furnisher: row[5],
                     source_file: file.original_filename)
      end
    end
  end
end
