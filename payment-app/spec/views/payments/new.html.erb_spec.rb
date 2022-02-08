require 'rails_helper'

RSpec.describe "payments/new", type: :view do
  before(:each) do
    assign(:payment, Payment.new(
      amount: "9.99",
      description: "MyText",
      payer_user_id: "1",
      receiver_user_id: "2"
    ))
  end

  it "renders new payment form" do
    render

    assert_select "form[action=?][method=?]", payments_path, "post" do

      assert_select "input[name=?]", "payment[amount]"

      assert_select "textarea[name=?]", "payment[description]"

      assert_select "input[name=?]", "payment[payer_user_id]"

      assert_select "input[name=?]", "payment[receiver_user_id]"
    end
  end
end
