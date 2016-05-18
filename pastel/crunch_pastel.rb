require 'csv'
require 'pry'
USD_TO_ZAR = 15.91
@csv = CSV.table('report.csv')

@expenses = Hash.new(0)
@income = Hash.new(0)

def load_amounts
  @csv.each do |row|
    @expenses[row[:category]] += row[:spent].to_f if row[:spent].to_f > 0.0
    @income[row[:category]] += row[:received].to_f if row[:received].to_f > 0.0
  end
end

def print_transactions(expenses)
  expenses.each do |category, amount|
    puts "#{category}: #{amount / USD_TO_ZAR}"
  end
end

load_amounts
puts ""
puts "EXPENSES"
print_transactions(@expenses)
puts ""
puts "INCOME"
print_transactions(@income)
