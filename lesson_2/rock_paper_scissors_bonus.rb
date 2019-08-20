require 'set'

MAX_WINS = 5

VALID_CHOICES = %w[rock paper scissors lizard spock].freeze

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
].freeze

WINNING_MESSAGE = {
  Set['scissors', 'paper'] => "Scissors cut Paper",
  Set['paper', 'rock'] => "Paper covers Rock",
  Set['rock', 'lizard'] => "Rock crushes Lizard",
  Set['lizard', 'spock'] => "Lizard poisons Spock",
  Set['spock', 'scissors'] => "Spock smashes Scissors",
  Set['scissors', 'lizard'] => "Scissors decapitate Lizard",
  Set['lizard', 'paper'] => "Lizard eats Paper",
  Set['paper', 'spock'] => "Paper disproves Spock",
  Set['spock', 'rock'] => "Spock vaporizes Rock",
  Set['rock', 'scissors'] => "Rock crushes Scissors"
}.freeze

INITIAL_SCORE = {
  user: 0,
  computer: 0
}

def prompt(message)
  puts "=> #{message}"
end

def valid_choice?(choice)
  VALID_CHOICES.include?(choice)
end

def get_user_choice
  loop do
    prompt "Enter your choice (#{VALID_CHOICES.join(', ')})"
    choice = gets.chomp
    break choice if valid_choice?(choice)

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
  WINNING_MESSAGE.fetch(Set[player1, player2], "")
end

# Returns 1 if player 1 wins, 0 if tie
# and -1 if player 2 wins
def result(player1, player2)
  if player1 == player2
    0
  elsif win?(player1, player2)
    1
  else
    -1
  end
end

def result_message(result)
  case result
  when 0 then "It's a tie."
  when 1 then "You won!"
  when -1 then "Computer won."
  end
end

def display_result(winning_msg, result_msg)
  prompt winning_msg
  prompt result_msg
end

def quit?
  prompt 'Do you want to play again?'
  answer = gets.chomp
  !answer.downcase.start_with?('y')
end

def game_over?(score)
  score.values.max >= MAX_WINS
end

def update_score(score, result)
  updated_score = score.clone
  if result == -1
    updated_score[:computer] += 1
  elsif result == 1
    updated_score[:user] += 1
  end
  updated_score
end

def display_grand_winner(score)
  if (score[:user] > score[:computer])
    prompt "You are the GRAND WINNER!!!"
  else
    prompt "Computer is the GRAND WINNER!!!"
  end
end

def play_game(score)
  loop do
    choice = get_user_choice
    computer_choice = get_computer_choice

    prompt "You chose #{choice}, computer chose #{computer_choice}"
    
    computed_result = result(choice, computer_choice)
    winning_msg = winning_message(choice, computer_choice)
    result_msg = result_message(computed_result)
    score = update_score(score, computed_result)

    display_result(winning_msg, result_msg)

    if game_over?(score)
      break score
    elsif quit?
      break false
    end
  end
end

prompt 'Welcome to Rock, Paper, Scissors, Lizard, Spock!'
updated_score = play_game(INITIAL_SCORE)
if updated_score
  display_grand_winner(updated_score)
end

prompt 'Thanks for playing. Have a good day!'
