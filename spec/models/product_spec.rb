require 'rails_helper'

RSpec.describe Product, type: :model do
  test_cat = Category.create(:name => 'test_category')
  subject { Product.new(name: "Anything", price_cents: 10, quantity: 'Anything', category: test_cat) }
  describe 'Validations' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is invalid without a category" do
      subject.category = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Category can't be blank")
    end

    it "is invalid without a quantity" do
      subject.quantity = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Quantity can't be blank")
    end

    it "is invalid without a price" do
      subject.price_cents = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include('Price is not a number')
      expect(subject.errors.full_messages).to include('Price cents is not a number')
    end

    it "is invalid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Name can't be blank")
    end
  end
end
