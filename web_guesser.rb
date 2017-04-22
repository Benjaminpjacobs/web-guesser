require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)
GAME_OVER = "You got it right! The SECRET SECRET_NUMBER is #{SECRET_NUMBER}"

TH = "Too High!"
TL = "Too Low!"
W = "Way "



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
    message = compare_guess(guess)
  end
  message
end

def compare_guess(guess)
  if guess.to_i > SECRET_NUMBER + 5
    @@color = '#ff0000'
    message = W + TH
  elsif guess.to_i > SECRET_NUMBER
    @@color = '#ff4d4d'
    message = TH
  elsif guess.to_i < SECRET_NUMBER - 5
    @@color = '#ff0000'
    message = W + TL
  elsif guess.to_i < SECRET_NUMBER
    @@color = '#ff4d4d'
    message = "Too Low!"
  elsif guess.to_i == SECRET_NUMBER
    @@color = '#33cc33'
    message = GAME_OVER
  end
  message
end