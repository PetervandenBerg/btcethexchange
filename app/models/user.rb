class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :trades
  has_many :transactions
  has_many :addresses
  has_many :gambles

  def check_balance
    balance = 0
    debit_count = self.transactions.where(credit: 0).count * 0.0001

    self.transactions.each do |t|
      balance += t.credit
      balance -= t.debit
    end
    balance - debit_count
  end 

  def check_server_balance
    btcserver.getbalance self.id.to_s, 0
  end

end
