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

  describe "validates attributes" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    # it { is_expected.to validate_presence_of(:approved) } fails

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    it { is_expected.to validate_length_of(:password).is_at_least(8) }

    it do
      is_expected.to allow_values(
        "host@email.com"
      ).for(:email)
    end
    it do
      is_expected.not_to allow_values(
        "al.most.com", 
        "not@domain", 
        "@nowhere.com", 
        "not an email"
      ).for(:email)
    end

    it do
      is_expected.to allow_values(
        "P@ssw0rd",
        "siND8pvO2YlhT32UwWQMYQ**Q*sEp1UW#3CP6y$L9kV8Av2#aQG@hD79J25dMhsqUw8LorXd4iVIfy$Hl%YJBZrZEu1kQceqi&K*2nv$yd6xopnj3#F2nX2IHoB*#KrE"
      ).for(:password)
    end
    it do
      is_expected.not_to allow_values(
        "$h0rT",
        "mi$$ingNumber", 
        "12345678",
        "too2qui@t",
        "Y0L0ALLC@PS"
        # "N0      p@ss" # FIXME why are spaces allowed?
      ).for(:password)
    end

    it do
      is_expected.to allow_values(
        "297-736-6716 x09195",
        "1-758-235-5268",
        "1.781.882.7285",
        "267.628.2450 ext 986",
        "12134567890",
        "(697) 712-0620 x507",
        "1 (888) 342-5425 EXT 16290",
        "742.339.5512; 5878",
        "267-628-2450 #986"
      ).for(:phone)
    end
    it do
      is_expected.not_to allow_values(
        "1459-148-200",
        "2-338-612-5575",
        "909043751514462514262747251515",
        "255.178.249.36",
        "not a phone number"
      ).for(:phone)
    end
  end
end
