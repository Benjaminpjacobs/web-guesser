require 'sinatra'
require 'sinatra/reloader'


TH = "Too High!"
TL = "Too Low!"
W = "Way "
@@secret_number = rand(100)
@@guess_count = 5
GAME_OVER = "You got it right! The SECRET secret_number is #{@@secret_number}"



get '/' do 
  guess = params["guess"]
  message = check_guess(guess)
  erb :index, :locals => {:message => message, :color => @@color }
end

def check_guess(guess)
  if guess.nil?
    @@color = '#ff0000'
    message = ''
  else
    @@guess_count -= 1
    message = compare_guess(guess)
  end
  message
end

def compare_guess(guess)
  if guess.to_i == @@secret_number
    @@color = '#33cc33'
    message = GAME_OVER
  elsif @@guess_count == 0
    @@secret_number = rand(100)
    @@guess_count = 5
    message = "Game over, new number selected"
  elsif guess.to_i > @@secret_number + 5
    @@color = '#ff0000'
    message = W + TH
  elsif guess.to_i > @@secret_number
    @@color = '#ff4d4d'
    message = TH
  elsif guess.to_i < @@secret_number - 5
    @@color = '#ff0000'
    message = W + TL
  elsif guess.to_i < @@secret_number
    @@color = '#ff4d4d'
    message = "Too Low!"
  end
  message
end