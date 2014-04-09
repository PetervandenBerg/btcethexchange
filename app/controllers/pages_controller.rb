class PagesController < ApplicationController
  before_filter :authenticate_user!, only: [:finances]
  
  def home
    @order = Order.new
  end

  def status
  end

  def about
  end

  def contact
  end

  def finances
    @transaction = Transaction.new
  end

end
