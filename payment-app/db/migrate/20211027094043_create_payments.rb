class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.text :description
      t.bigint :payer_user_id
      t.bigint :receiver_user_id

      t.timestamps
    end
  end
end
