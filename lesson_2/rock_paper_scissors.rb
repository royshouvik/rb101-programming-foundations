VALID_CHOICES = %w[rock paper scissors]

WINNING_CHOICES = [
  { user: 'rock', computer: 'scissors' },
  { user: 'paper', computer: 'rock' },
  { user: 'scissors', computer: 'paper' }
]

def prompt(message)
  puts "=> #{message}"
end

def get_user_choice
  loop do
    prompt "Enter your choice (#{VALID_CHOICES.join(', ')})"
    choice = gets.chomp
    break choice if VALID_CHOICES.include?(choice)

    prompt "That's not a valid choice"
  end
end

def get_computer_choice
  VALID_CHOICES.sample
end

def display_result(user, computer)
  if user == computer
    prompt "It's a tie."
  elsif WINNING_CHOICES.include?(user: user, computer: computer)
    prompt 'You won!'
  else
    prompt 'Computer won.'
  end
end

def play_again?
  prompt 'Do you want to play again?'
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def start_game
  choice = get_user_choice
  computer_choice = get_computer_choice
  prompt "You chose #{choice}, computer chose #{computer_choice}"
  display_result(choice, computer_choice)

  start_game if play_again?
end

def main
  prompt 'Welcome to Rock, Paper, Scissors'
  start_game
  prompt 'Thanks for playing. Have a good day!'
end

main
