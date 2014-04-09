class TransactionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @transactions = current_user.transactions.order(created_at: :desc)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = current_user.id
    @transaction.currency_type = "BTC"

    respond_to do |format|
      if @transaction.save

        hash = btcserver.sendfrom(@transaction.user_id.to_s,@transaction.address,@transaction.debit.to_f)

        @transaction.transaction_hash = hash
        @transaction.save

        @transaction.create_credit_transaction

        format.html { redirect_to pages_finances_path, notice: 'Transaction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @transaction }
      else
        format.html { redirect_to pages_finances_path, notice: @transaction.errors.messages }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def transaction_params
      params.require(:transaction).permit(:credit, :debit, :address, :transaction_hash, :type, :user_id, :processed)
    end
end