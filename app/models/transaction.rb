class Transaction < ActiveRecord::Base
  belongs_to :user
  validates_numericality_of :debit, greater_than_or_equal: 0
  validates_numericality_of :debit, less_than_or_equal_to: :check_user_amount

  #Right now its set to server balance cause of fee's not being counted.
  def check_user_amount
    self.user.check_server_balance
  end

  def create_credit_transaction

    if Address.where(address: self.address).present?
      unless Address.find_by(address: self.address).user.id == self.user.id
        Transaction.create(
            credit: self.debit,
            address: self.address,
            transaction_hash: self.transaction_hash,
            currency_type: "BTC",
            processed: true,
            user_id:  Address.find_by(address: self.address).user.id
          )
      end
    end

  end

end

