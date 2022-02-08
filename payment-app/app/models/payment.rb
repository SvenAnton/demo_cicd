class Payment < ApplicationRecord
    validates :amount, presence: true
    validate :payer_exists?, :receiver_exists?

    def payer_name
        User.find(self.payer_user_id).name
    end

    def receiver_name
        User.find(self.receiver_user_id).name
    end

    def payer_exists?
        unless User.exists?(self.payer_user_id)
            errors.add(:incorrect_user_id, "There is no payer with such user ID")
        end
    end

    def receiver_exists?
        unless User.exists?(self.receiver_user_id)
            errors.add(:incorrect_user_id, "There is no receiver with such user ID")
        end
    end

end
