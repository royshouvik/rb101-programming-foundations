require 'set'

VALID_CHOICES = %w[rock paper scissors lizard spock]

WINNING_CHOICES = [
  { player1: 'scissors', player2: 'paper' },
  { player1: 'paper', player2: 'rock' },
  { player1: 'rock', player2: 'lizard' },
  { player1: 'lizard', player2: 'spock' },
  { player1: 'spock', player2: 'scissors' },
  { player1: 'scissors', player2: 'lizard' },
  { player1: 'lizard', player2: 'paper' },
  { player1: 'paper', player2: 'spock' },
  { player1: 'spock', player2: 'rock' },
  { player1: 'rock', player2: 'scissors' }
]

WINNING_MESSAGE = {
Set['scissors', 'paper']  => "Scissors cut Paper",
Set['paper', 'rock']      => "Paper covers Rock",
Set['rock', 'lizard']     => "Rock crushes Lizard",
Set['lizard', 'spock']    => "Lizard poisons Spock",
Set['spock', 'scissors']  => "Spock smashes Scissors",
Set['scissors', 'lizard'] => "Scissors decapitate Lizard",
Set['lizard', 'paper']    => "Lizard eats Paper",
Set['paper', 'spock']     => "Paper disproves Spock",
Set['spock', 'rock']      => "Spock vaporizes Rock",
Set['rock', 'scissors']   => "Rock crushes Scissors"
}

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

def win?(player1, player2)
  WINNING_CHOICES.include?(player1: player1, player2: player2)
end

def winning_message(player1, player2)
  WINNING_MESSAGE.fetch(Set[player1, player2])
end

def result(user, computer)
  if user == computer
    "It's a tie."
  elsif win?(user, computer)
    'You won!'
  else
    'Computer won.'
  end
end

def display_result(user, computer)
  prompt winning_message(user, computer)
  prompt result(user, computer)
end

def play_again?
  prompt 'Do you want to play again?'
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def start_game
  loop do
    choice = get_user_choice
    computer_choice = get_computer_choice
    prompt "You chose #{choice}, computer chose #{computer_choice}"
    display_result(choice, computer_choice)

    break unless play_again?
  end
end

def main
  prompt 'Welcome to Rock, Paper, Scissors, Lizard, Spock!'
  start_game
  prompt 'Thanks for playing. Have a good day!'
end

main
