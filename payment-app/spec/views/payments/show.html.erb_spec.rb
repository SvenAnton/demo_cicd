require 'rails_helper'

RSpec.describe "payments/show", type: :view do
  before(:each) do
    @payment = assign(:payment, create(:payment))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/50.01/)
    expect(rendered).to match(/loan/)
    expect(rendered).to match(/Sven/)
    expect(rendered).to match(/Vladimir/)
  end
end
