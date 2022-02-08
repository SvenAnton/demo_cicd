require 'rails_helper'

RSpec.describe Payment, type: :model do
  
  subject(:payment) { create(:payment) }
  subject(:empty_payment) { Payment.new() }
  subject(:payment_payer_user_id) { payment.payer_user_id }

  describe "payment" do
    context "missing amount" do
      it { expect(empty_payment.valid?).to be false }
      it { expect{ empty_payment.save! }.to raise_error(an_instance_of(ActiveRecord::RecordInvalid)) }
    end
    context "amount is present" do
      it { expect(payment.valid?).to be true }
    end

    context "payer_user_id" do
      context "represents a user" do
        it { expect(payment_payer_user_id).not_to be_nil }
        it { expect(User.find(payment_payer_user_id)).to be_instance_of(User) }
      end
      context "does not represent a user" do
        subject { Payment.new(
          "amount"=>50,
          "description"=>"test",
          "payer_user_id"=>1222,
          "receiver_user_id"=>2) }
        it { expect(subject.payer_user_id).not_to be_nil }
        it { expect(subject.valid?).to be false }
        it { expect{ empty_payment.save! }.to raise_error(an_instance_of(ActiveRecord::RecordInvalid)) }
      end
    end

    context "receiver_user_id" do
      context "represents a user" do
        it { expect(payment_payer_user_id).not_to be_nil }
        it { expect(User.find(payment_payer_user_id)).to be_instance_of(User) }
      end
      context "does not represent a user" do
        subject { Payment.new(
          "amount"=>50,
          "description"=>"test",
          "payer_user_id"=>1,
          "receiver_user_id"=>22222) }
        it { expect(subject.payer_user_id).not_to be_nil }
        it { expect(subject.valid?).to be false }
        it { expect{ empty_payment.save! }.to raise_error(an_instance_of(ActiveRecord::RecordInvalid)) }
      end
    end

  end


end
