require 'rails_helper'

describe User do
  let(:valid_user) { build(:user) }
  subject { valid_user }

  context 'when user is valid' do
    it { expect(valid_user).to be_valid }

    it 'saves user' do
      valid_user.save
      expect(valid_user.save).to be(true)
    end

    it 'has no error messages' do
      valid_user.save
      expect(valid_user.errors.count).to eq(0)
    end
  end

  context "when email is not present" do
    let(:invalid_user) { build(:user, email: "") }
    
    it { expect(invalid_user).to_not be_valid }

    it "does not save invalid user" do
      invalid_user.save
      expect(invalid_user.save).to be(false)
    end
    
    it "returns an error message" do
      invalid_user.save
      expect(invalid_user.errors[:email]).to include("can't be blank")
    end 
  end

  context "when password is not present" do
    let(:invalid_user) { build(:user, password: "")}
    
    it { expect(invalid_user).to_not be_valid }

    it "does not save invalid user" do
      invalid_user.save
      expect(invalid_user.save).to be(false)
    end

    it "returns an error message" do
      invalid_user.save
      expect(invalid_user.errors[:password]).to include("can't be blank")
    end
  end

  context "when email is not unique" do
    let!(:original_user) { create(:user) }
    let(:dup_user) { build(:user, email: original_user[:email]) }

    it { expect(dup_user).to_not be_valid }

    it "does not save invalid user" do
      dup_user.save
      expect(dup_user.save).to be(false)
    end

    it "returns an error message" do
      dup_user.save
      expect(dup_user.errors[:email]).to include("has already been taken")
    end
  end

  context "when password is too short" do
    let(:invalid_user) { build(:user, password: "$h0rT") }

    it { expect(invalid_user).to_not be_valid }

    it "does not save invalid user" do
      invalid_user.save
      expect(invalid_user.save).to be(false)
    end

    it "returns an error message" do
      invalid_user.save
      expect(invalid_user.errors[:password]).to include("is too short (minimum is 8 characters)")
    end
  end

  context "when password is missing a special character" do
    let(:invalid_user) { build(:user, password: "Mis1ng") }

    it { expect(invalid_user).to_not be_valid }

    it "does not save invalid user" do
      invalid_user.save
      expect(invalid_user.save).to be(false)
    end

    it "returns an error message" do
      invalid_user.save
      expect(invalid_user.errors[:password]).to include("must include 1 uppercase, 1 lowercase, 1 digit and 1 special character.")
    end
  end

  context "when password is missing a digit" do
    let(:invalid_user) { build(:user, password: "noNum!") }

    it { expect(invalid_user).to_not be_valid }

    it "does not save invalid user" do
      invalid_user.save
      expect(invalid_user.save).to be(false)
    end

    it "returns an error message" do
      invalid_user.save
      expect(invalid_user.errors[:password]).to include("must include 1 uppercase, 1 lowercase, 1 digit and 1 special character.")
    end
  end

  context "when password is missing a lowercase letter" do
    let(:invalid_user) { build(:user, password: "Y@LP1N") }

    it { expect(invalid_user).to_not be_valid }

    it "does not save invalid user" do
      invalid_user.save
      expect(invalid_user.save).to be(false)
    end

    it "returns an error message" do
      invalid_user.save
      expect(invalid_user.errors[:password]).to include("must include 1 uppercase, 1 lowercase, 1 digit and 1 special character.")
    end
  end

  context "when password is missing an uppercase letter" do
    let(:invalid_user) { build(:user, password: "2qui@t") }

    it { expect(invalid_user).to_not be_valid }

    it "does not save invalid user" do
      invalid_user.save
      expect(invalid_user.save).to be(false)
    end

    it "returns an error message" do
      invalid_user.save
      expect(invalid_user.errors[:password]).to include("must include 1 uppercase, 1 lowercase, 1 digit and 1 special character.")
    end
  end

  context "when email is missing @ character" do
    let(:invalid_user) { build(:user, email: "al.most.com") }

    it { expect(invalid_user).to_not be_valid }

    it "does not save invalid user" do
      invalid_user.save
      expect(invalid_user.save).to be(false)
    end

    it "returns an error message" do
      invalid_user.save
      expect(invalid_user.errors[:email]).to include("is invalid")
    end
  end

  context "when email is missing top-level domain" do
    let(:invalid_user) { build(:user, email: "not@domain") }

    it { expect(invalid_user).to_not be_valid }

    it "does not save invalid user" do
      invalid_user.save
      expect(invalid_user.save).to be(false)
    end

    it "returns an error message" do
      invalid_user.save
      expect(invalid_user.errors[:email]).to include("is invalid")
    end
  end

  context "when email is missing host" do
    let(:invalid_user) { build(:user, email: "@nowhere.com") }

    it { expect(invalid_user).to_not be_valid }

    it "does not save invalid user" do
      invalid_user.save
      expect(invalid_user.save).to be(false)
    end

    it "returns an error message" do
      invalid_user.save
      expect(invalid_user.errors[:email]).to include("is invalid")
    end
  end
end
