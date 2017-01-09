require 'test_helper'

class SaleTest < ActiveSupport::TestCase
  test "import txt" do
    file = "exemplo.txt"
    # file = CSV.generate(headers: true, :col_sep => "\t") do |csv|
    CSV.open(file, "wb", headers: true, :col_sep => "\t") do |csv|
      csv << ["Comprador", "descrição", "Preço Unitário", "Quantidade", "Endereço", "Fornecedor"]
      csv << ["Xuxa", "R$10 off R$20 of food", "10.0", "2", "987 Fake St", "Bobs Pizza"]
      csv << ["Amy Pond", "R$30 of awesome for R$10", "10.0", "5", "456 Unreal Rd", "Toms Awesome Shop"]
      csv << ["Marty McFly", "R$20 Sneakers for R$5", "5.0", "1", "123 Fake St", "Sneaker Store Emporium"]
      csv << ["Snake Plissken", "R$20 Sneakers for R$5", "5,2", "4", "123 Fake St", "Sneaker Store Emporium"]
    end
    Sale.where(source_file: 'exemplo.txt').destroy_all
    assert_difference 'Sale.count', 4 do
      Sale.import(Rack::Test::UploadedFile.new(file, 'text/csv'))
    end
  end
end
