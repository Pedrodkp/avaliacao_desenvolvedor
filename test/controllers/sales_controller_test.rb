require 'test_helper'

class SalesControllerTest < ActionController::TestCase
  setup do
    @sale = sales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sale" do
    assert_difference('Sale.count') do
      post :create, sale: { address: @sale.address, amount: @sale.amount, customer: @sale.customer, description: @sale.description, furnisher: @sale.furnisher, price: @sale.price, source_file: @sale.source_file }
    end

    assert_redirected_to sale_path(assigns(:sale))
  end

  test "should show sale" do
    get :show, id: @sale
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sale
    assert_response :success
  end

  test "should update sale" do
    patch :update, id: @sale, sale: { address: @sale.address, amount: @sale.amount, customer: @sale.customer, description: @sale.description, furnisher: @sale.furnisher, price: @sale.price, source_file: @sale.source_file }
    assert_redirected_to sale_path(assigns(:sale))
  end

  test "should destroy sale" do
    assert_difference('Sale.count', -1) do
      delete :destroy, id: @sale
    end

    assert_redirected_to sales_path
  end

  test "should import sales from files" do
    file = "exemplo.txt"
    CSV.open(file, "wb", headers: true, :col_sep => "\t") do |csv|
      csv << ["Comprador", "descrição", "Preço Unitário", "Quantidade", "Endereço", "Fornecedor"]
      csv << ["Xuxa", "R$10 off R$20 of food", "10.0", "2", "987 Fake St", "Bobs Pizza"]
      csv << ["Amy Pond", "R$30 of awesome for R$10", "10.0", "5", "456 Unreal Rd", "Toms Awesome Shop"]
      csv << ["Marty McFly", "R$20 Sneakers for R$5", "5.0", "1", "123 Fake St", "Sneaker Store Emporium"]
      csv << ["Snake Plissken", "R$20 Sneakers for R$5", "5,2", "4", "123 Fake St", "Sneaker Store Emporium"]
    end
    Sale.where(source_file: 'exemplo.txt').destroy_all
    
    post :import, :file => Rack::Test::UploadedFile.new(file, 'text/csv')
    assert_redirected_to sales_path
    assert_equal "Importado, valor total das vendas do arquivo: 95.0", flash[:notice]
  end
end
