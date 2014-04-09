class Order < ActiveRecord::Base
  has_many :trades
  belongs_to :user

  def order_status
    start_time = self.created_at
    end_time = start_time + 1.day
    if Time.now.between?(start_time, end_time)
      self.status = "pending"
    else
      self.status = "cancelled"
    end
  end

  def order_funds
    
  end

end
