require 'rails_helper'

RSpec.describe "payments/index", type: :view do
  before(:each) do
    assign(:payments, [create(:payment), create(:payment)])
  end

  it "renders a list of payments" do
    render
    assert_select "tr>td", text: "50.01".to_s, count: 2
    assert_select "tr>td", text: "loan".to_s, count: 2
    assert_select "tr>td", text: "Sven".to_s, count: 2
    assert_select "tr>td", text: "Vladimir".to_s, count: 2
  end
end
