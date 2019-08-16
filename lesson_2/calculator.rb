puts 'Enter the first number'
number1 = gets.chomp

puts 'Enter the second number'
number2 = gets.chomp

puts 'Enter the operation to perform:
1 - Addition,
2 - Subtraction,
3 - Multiplication and
4 - Division'

operator = gets.chomp

result = case operator
         when '1' then number1.to_i + number2.to_i
         when '2' then number1.to_i - number2.to_i
         when '3' then number1.to_i * number2.to_i
         when '4' then number1.to_f / number2.to_i
         end

puts "The result is #{result}"
