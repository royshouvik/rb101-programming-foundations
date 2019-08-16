require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')


OP_VERB = {
  "1" => "op_add",
  "2" => "op_sub",
  "3" => "op_mul",
  "4" => "op_div"
}

def prompt(message)
  if MESSAGES.has_key? message
    puts "=> #{MESSAGES[message]}"
  else
    puts "=> #{message}"
  end
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
      prompt "number_error"
    end
  end
end

def get_op_input
  prompt "operator_prompt"
  
  loop do
    input = gets.chomp
    if %w(1 2 3 4).include?(input)
      break input
    else
      prompt "operator_error"
    end
  end
end

def calculate
  loop do
    number1 = get_number_input("number1_prompt")
    number2 = get_number_input("number2_prompt")
    operator = get_op_input

    prompt "#{OP_VERB[operator]} #{MESSAGES["op_message"]}"

    result = case operator
    when '1' then number1 + number2
    when '2' then number1 - number2
    when '3' then number1 * number2
    when '4' then number1.to_f / number2
    end

    prompt "#{MESSAGES["result"]} #{result}"

    prompt "again_prompt"
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end
end

def get_name
  loop do
    name = gets.chomp
    if name.empty?
      prompt "name_error"
    else
      break name.downcase.capitalize
    end
  end
end

def greet
  prompt "welcome"
  name = get_name
  prompt "#{MESSAGES["hi"]} #{name}!"
end

def main
  greet
  calculate
  prompt "bye"
end

main

