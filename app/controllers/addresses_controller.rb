class AddressesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @address = Address.new
  end

  def create
    @address = Address.new
    @address.user_id = current_user.id   
    new_address = btcserver.getnewaddress current_user.id.to_s
    @address.address = new_address

    respond_to do |format|
      if @address.save
        format.html { redirect_to pages_finances_path, notice: 'Address was successfully created.' }
        format.json { render action: 'show', status: :created, location: @address }
      else
        format.html { render action: 'new' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

end