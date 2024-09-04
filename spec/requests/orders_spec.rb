require 'rails_helper'

RSpec.describe "OrdersControllers", type: :request do
  let!(:customer) { FactoryBot.create(:customer) }

  describe "get orders_path" do
    it "renders the index view" do
      FactoryBot.create_list(:order, 10, customer: customer)
      get orders_path
      expect(response).to render_template(:index)
    end
  end

  describe "get order_path" do
    it "renders the :show template" do
      order = FactoryBot.create(:order, customer: customer)
      get order_path(id: order.id)
      expect(response).to render_template(:show)
    end

    it "redirects to the index path if the order id is invalid" do
      get order_path(id: 5000)
      expect(response).to redirect_to orders_path
    end
  end

  describe "get new_order_path" do
    it "renders the :new template" do
      get new_order_path
      expect(response).to render_template(:new)
    end
  end

  describe "get edit_order_path" do
    it "renders the :edit template" do
      order = FactoryBot.create(:order, customer: customer)
      get edit_order_path(id: order.id)
      expect(response).to render_template(:edit)
    end
  end

  describe "post orders_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      customer = FactoryBot.create(:customer)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      expect {
        post orders_path, params: { order: order_attributes }
      }.to change(Order, :count).by(1)
      expect(response).to redirect_to order_path(id: Order.last.id)
    end
  end

  describe "post orders_path with invalid data" do
    it "does not save a new entry or redirect" do
      order_attributes = FactoryBot.attributes_for(:order, product_name: nil)
      expect {
        post orders_path, params: { order: order_attributes }
      }.to_not change(Order, :count)
      expect(response).to render_template(:new)
    end
  end

  describe "put order_path with valid data" do
    it "updates an entry and redirects to the show path for the order" do
      order = FactoryBot.create(:order, customer: customer)
      updated_attributes = { product_name: "UpdatedProduct" }
      put order_path(id: order.id), params: { order: updated_attributes }
      order.reload
      expect(order.product_name).to eq("UpdatedProduct")
      expect(response).to redirect_to order_path(id: order.id)
    end
  end

  describe "put order_path with invalid data" do
    it "does not update the order record or redirect" do
      order = FactoryBot.create(:order, customer: customer)
      put order_path(id: order.id), params: { order: { product_name: "" } }
      order.reload
      expect(order.product_name).to_not eq("")
      expect(response).to render_template(:edit)
    end
  end

  describe "delete an order record" do
    it "deletes an order record" do
      order = FactoryBot.create(:order, customer: customer)
      expect {
        delete order_path(id: order.id)
      }.to change(Order, :count).by(-1)
      expect(response).to redirect_to orders_path
    end
  end
end