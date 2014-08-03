require 'bundler'
Bundler.require
require './lib/tic_tac_toe.rb'

class App < Sinatra::Application
  @@game = TicTacToe.new

  get '/' do
    @@game = TicTacToe.new
    redirect '/play'
  end

  get '/play' do
    @message = @@game.message
    @board = @@game.board
    erb :index
  end

  post '/move' do
    @@game.user_move(params['move'])
    if @@game.free_space?
      @@game.computer_move
    end
    redirect '/play'
  end

end