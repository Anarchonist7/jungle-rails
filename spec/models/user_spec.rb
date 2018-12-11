require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(first_name: "Anything", last_name: "Anything", email: 'Anything', password: 'Anything', password_confirmation: 'Anything' ) }
  describe 'Validations' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is invalid without a first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "is invalid without a last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it "must have password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "must have matching password" do
      subject.password_confirmation = 'jimmy'
      subject.password = 'bobby'
      expect(subject).to_not be_valid
    end

    it "must have email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "passwords must be at least 5 characters long" do
      subject.password = "smal"
      subject.password_confirmation = "smal"
      subject.save
      expect(subject.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end

    it "must have unique email" do
      test_user = User.create(:first_name => 'yar', :last_name => 'yar', :email => 'bim', :password => 'anything', :password_confirmation => 'anything')
      test_user.save
      subject.email = 'bim'
      subject.save
      expect(subject.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    it "must match an existing user" do
      test_user = User.create(:first_name => 'yar', :last_name => 'yar', :email => 'bim', :password => 'anything', :password_confirmation => 'anything')
      new_user = User.authenticate_with_credentials('bim', 'anything')
      expect(new_user).to eq test_user
    end

    it "must match email regardles of case" do
      test_user = User.create(:first_name => 'yar', :last_name => 'yar', :email => 'bim', :password => 'anything', :password_confirmation => 'anything')
      new_user = User.authenticate_with_credentials('BIM', 'anything')
      expect(new_user).to eq test_user
    end

    it "must match email regardles of whitespace" do
      test_user = User.create(:first_name => 'yar', :last_name => 'yar', :email => 'bim', :password => 'anything', :password_confirmation => 'anything')
      new_user = User.authenticate_with_credentials(' bim', 'anything')
      expect(new_user).to eq test_user
    end
  end
end
