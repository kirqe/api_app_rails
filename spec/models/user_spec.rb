require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }

  it { should be_valid }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }
  it { should validate_uniqueness_of(:auth_token) }

  describe "#generate_authenticaion_token!" do
    it "generates a unique token" do
      allow(Devise).to receive(:friendly_token).and_return("uniqToken123")
      @user.generate_authenticaion_token!
      expect(@user.auth_token).to eq "uniqToken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "uniqToken123")
      @user.generate_authenticaion_token!
      expect(@user.auth_token).not_to eq existing_user.auth_token
    end
  end

  describe "#products association" do
    before do
      @user.save
      3.times { FactoryGirl.create :product, user: @user }
    end

    it "destroys the associated products on self destruct" do
      products = @user.products
      @user.destroy
      products.each do |product|
        expect(Product.find(product)).to rails_errors ActiveRecord::RecordNotFound
      end
    end

  end



  it { should have_many(:products) }
  it { should have_many(:orders) }
end
