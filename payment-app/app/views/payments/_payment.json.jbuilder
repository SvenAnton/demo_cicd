json.extract! payment, :id, :amount, :description, :payer_user_id, :receiver_user_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
