require 'csv'
require 'pry'
@csv = CSV.table('transactions.csv')

@missions_transactions = Hash.new(0)
@photography_transactions = Hash.new(0)
@air_travel_amounts = []

def year(row)
  row[:date].match(/\d{4}$/)[0].to_i
end

def add(row)
  if row[:transaction_type] == "debit"
    -row[:amount]
  else
    row[:amount]
  end
end

def load_amounts
  categories = []
  @csv.each do |row|
    if row[:labels].include?("Tax Missions") && year(row) == 2015
      @missions_transactions[row[:category]] += add(row)
    elsif row[:labels].include?("Tax Photography") && year(row) == 2015
      @photography_transactions[row[:category]] += add(row)
    end
  end
end

def print_transactions(transactions)
  transactions.each do |category, amount|
    puts "#{category}: #{amount}"
  end
end

load_amounts
puts "MISSIONS TAX RELATED EXPENSES"
print_transactions(@missions_transactions)
puts ""
puts "PHOTOGRAPHY TAX RELATED EXPENSES"
print_transactions(@photography_transactions)
