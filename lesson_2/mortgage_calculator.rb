def prompt(message)
  puts "=> #{message}"
end

def greet
  prompt "Welcome to Mortgage Calculator v0.1! What's your name?"
  name = ''
  loop do
    name = gets.chomp
    break unless name.empty?

    prompt 'Please enter a valid name'
  end
  prompt "Hi, #{name.downcase.capitalize}"
end

def valid_int?(number)
  number.to_i.to_s == number
end

def valid_number?(number)
  valid_int?(number) || number.to_f.to_s == number
end

def format_number(num)
  if num.include?('.')
    num.to_f
  else
    num.to_i
  end
end

def fmt_currency(num)
  "$#{format('%.2f', num)}"
end

def loan_amount_input
  prompt "What's the loan amount?"
  amount = 0
  loop do
    amount = gets.chomp
    break if valid_number?(amount)

    prompt 'Please enter a valid loan amount.'
  end
  format_number(amount)
end

def annual_rate_input
  prompt "What's the annual rate of interest (APR)?"
  rate = 0
  loop do
    rate = gets.chomp
    break if valid_number?(rate)

    prompt 'Please enter a valid rate of interest. Eg for 5% APR enter `5`'
  end
  format_number(rate) / 100.0
end

def duration_input
  prompt "What's the loan duration in months?"
  duration = 0
  loop do
    duration = gets.chomp
    break if valid_int?(duration)

    prompt 'Please enter a valid duration. Eg for 5 years enter `60`'
  end
  format_number(duration)
end

def inputs
  loan_amount = loan_amount_input
  annual_rate = annual_rate_input
  duration_in_months = duration_input
  [loan_amount, annual_rate, duration_in_months]
end

def calculate(amount, rate, duration)
  monthly_rate = rate / 12.0
  amount * (monthly_rate / (1 - (1 + monthly_rate)**-duration))
end

def main
  greet
  loan_amount, annual_rate, duration_in_months = inputs
  monthly_payment = calculate(loan_amount, annual_rate, duration_in_months)
  prompt "For a loan amount of #{fmt_currency(loan_amount)},
  for #{duration_in_months} months, at #{format('%.2f', annual_rate * 100)}%
  annual interest, the amount to pay each month is
  #{fmt_currency(monthly_payment)}"
end

main
