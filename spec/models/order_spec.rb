require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { Order.new(product_name: "Sample Product", product_count: 10, customer: FactoryBot.create(:customer)) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a product_name" do
    subject.product_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a product_count" do
    subject.product_count = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a customer" do
    subject.customer = nil
    expect(subject).to_not be_valid
  end

  it "is not valid if the product_count is not a positive integer" do
    subject.product_count = -1
    expect(subject).to_not be_valid

    subject.product_count = 0
    expect(subject).to_not be_valid

    subject.product_count = 1.5
    expect(subject).to_not be_valid

    subject.product_count = "abc"
    expect(subject).to_not be_valid
  end

  it "returns the correct product_name" do
    expect(subject.product_name).to eq("Sample Product")
  end

  it "returns the correct product_count" do
    expect(subject.product_count).to eq(10)
  end
end