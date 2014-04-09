namespace :transaction do

  desc "Saves transactions in the DB"
  task :create => :environment do

    h = BitcoinRPC.new('http://bit:kojn@127.0.0.1:8332')

    User.all.each do |u|
      transactions = h.listtransactions u.id.to_s

      transactions.each do |t|

        unless Transaction.where(transaction_hash: t["txid"]).count > 0
          Transaction.create(
            credit: t["amount"],
            address: t["address"],
            transaction_hash: t["txid"],
            currency_type: "BTC",
            processed: true,
            user_id: t["account"],
          )
        end

      end
    end 

  end

end