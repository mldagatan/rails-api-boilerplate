require 'rails_helper'

describe User do
  describe 'validations' do
    subject { build(:user) }

    context 'when user login with email' do
      it do
        is_expected.to validate_uniqueness_of(:email).case_insensitive
                                                     .scoped_to(:provider)
      end
      it { is_expected.to validate_presence_of(:email) }
    end
  end
end
