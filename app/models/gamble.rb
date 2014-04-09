class Gamble < ActiveRecord::Base
  belongs_to :user
  validates_numericality_of :amount, less_than_or_equal_to: :check_user_amount

  #Right now its set to server balance cause of fee's not being counted.
  def check_user_amount
    self.user.check_server_balance
  end

  def win_or_lose
    number = self.created_at.to_f.to_s[-1].to_i
    if number >= 6
      self.won = true
    else 
      self.won = false
    end
    self.save
  end

  def payout
    if self.won == true
      btcserver.move("1337", self.user_id.to_s, (self.amount * 2), 0)
    end
  end

end
