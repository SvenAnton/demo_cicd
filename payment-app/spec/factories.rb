
FactoryBot.define do

    factory :user, aliases: [:payer] do
      name { "Sven" }
      email  { "sven@hot.ee" }
      password { 'Masterpass123' }

      trait :receiver do
        name { "Vladimir" }
        email  { "vlad@hot.ee" }
        password { 'pass123' }
      end
    end

    factory :payment do
        amount { 50.01 }
        description { "loan" }
        payer_user_id { create(:payer).id }
        receiver_user_id { create(:user, :receiver).id }
    end
  end