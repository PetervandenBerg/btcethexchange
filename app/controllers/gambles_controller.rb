class GamblesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @gambles = Gamble.all
    @gamble = Gamble.new
  end

  def create
    @gamble = Gamble.new(gamble_params)
    @gamble.user_id = current_user.id

    respond_to do |format|
      if @gamble.save
        btcserver.move(@gamble.user_id.to_s, "1337", @gamble.amount, 0)
        @gamble.win_or_lose
        @gamble.payout
        format.html { redirect_to gambles_path, notice: 'Gamble was successfully created.' }
        format.json { render action: 'show', status: :created, location: @gamble }
      else
        format.html { render action: 'new' }
        format.json { render json: @gamble.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def gamble_params
      params.require(:gamble).permit(:amount, :currency_type, :user_id, :won)
    end
end
