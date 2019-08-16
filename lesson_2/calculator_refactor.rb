require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
# puts MESSAGES.inspect

OP_VERB = {
  "1" => MESSAGES["op_add"],
  "2" => MESSAGES["op_sub"],
  "3" => MESSAGES["op_mul"],
  "4" => MESSAGES["op_div"]
}

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  if num.include? '.'
    num.to_f.to_s == num
  else
    num.to_i.to_s == num
  end
end

def format_number(num)
  if num.include? '.'
    num.to_f
  else
    num.to_i
  end
end

def get_number_input(message)
  loop do
    prompt message
    input = gets.chomp
    if valid_number?(input)
      break format_number(input)
    else
      prompt(MESSAGES["number_error"])
    end
  end
end

def get_op_input
  prompt(MESSAGES["operator_prompt"])
  
  loop do
    input = gets.chomp
    if %w(1 2 3 4).include?(input)
      break input
    else
      prompt(MESSAGES["operator_error"])
    end
  end
end

def calculate
  loop do
    number1 = get_number_input(MESSAGES["number1_prompt"])
    number2 = get_number_input(MESSAGES["number2_prompt"])
    operator = get_op_input

    prompt "#{OP_VERB[operator]} #{MESSAGES["op_message"]}"

    result = case operator
    when '1' then number1 + number2
    when '2' then number1 - number2
    when '3' then number1 * number2
    when '4' then number1.to_f / number2
    end

    prompt "#{MESSAGES["result"]} #{result}"

    prompt MESSAGES["again_prompt"]
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end
end

def get_name
  loop do
    name = gets.chomp
    if name.empty?
      prompt MESSAGES["name_error"]
    else
      break name.downcase.capitalize
    end
  end
end

def greet
  prompt MESSAGES["welcome"]
  name = get_name
  prompt "#{MESSAGES["hi"]} #{name}!"
end

def main
  greet
  calculate
  prompt MESSAGES["bye"]
end

main

