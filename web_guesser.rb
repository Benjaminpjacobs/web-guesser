require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(100)
@@guess_count = 10

get '/' do 
  guess = params["guess"]
  message = check_guess(guess)
  if params["cheat"]
    erb :index, :locals => {:message => message + "</br>The SECRET NUMBER is #{@@secret_number}", :color => @@color }
  else
    erb :index, :locals => {:message => message, :color => @@color }
  end
end

def check_guess(guess)
  if guess.nil?
    @@color = 'rgb(199, 29, 29)'
    message = ''
  else
    @@guess_count -= 1
    message = check_count_compare_guess(guess)
  end
end

def check_count_compare_guess(guess)
  if @@guess_count == 0
    reset_game
    return game_over
  end
  compare_difference(guess)
end

def compare_difference(guess)
  diff = guess.to_i - @@secret_number

  is_correct = ->(diff) {diff == 0}
  is_way_too_high = ->(diff) {diff >= 5}
  is_too_high = ->(diff) {diff > 5}
  is_way_too_low = ->(diff) {diff <= -5}
  
  case diff
  when is_correct then correct
  when is_way_too_high then way_too_high
  when is_too_high then too_high
  when is_way_too_low then way_too_low
  else too_low
  end
end

private

  def reset_game
    @@secret_number = rand(100)
    @@guess_count = 10
  end

  def correct
    @@color = 'rgba(83, 206, 83, 0.8)'
    "You got it right! <br><br> The SECRET NUMBER is #{@@secret_number}"
  end

  def way_too_high
    @@color = 'rgba(199, 29, 29, 0.5)'
    "Way Too High!"
  end

  def too_high
    @@color = 'rgba(199, 29, 29, 0.9)'
    "Too High!"
  end

  def way_too_low
    @@color = 'rgba(199, 29, 29, 0.9)'
    "Way Too Low!"
  end

  def too_low
    @@color = 'rgba(199, 29, 29, 0.5)'
    "Too Low!"
  end

  def game_over
    @@color = 'rgba(199, 29, 29, 1.0)'
    "Game over, new number selected"
  end