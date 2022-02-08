require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:empty_user) { User.new() }
  subject(:correct_user) { create(:user) }

  describe "user" do
    context "name is missing" do
      it { expect(empty_user.valid?).to be false }
      it { expect{ empty_user.save! }.to raise_error(an_instance_of(ActiveRecord::RecordInvalid)) }
    end
    context "name is present" do
      it { expect(correct_user.valid?).to be true }
    end
  end

end
