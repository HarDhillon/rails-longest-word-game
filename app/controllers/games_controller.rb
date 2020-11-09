require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @words = []
    9.times { @words << ('A'..'Z').to_a.sample }
  end

  def score
    # timings
    time_start = params[:time].to_i
    time_end = Time.now
    time_end = time_end.strftime("%k%M%S").to_i
    time_taken = (time_end - time_start)

    # words
    attempt = params['created_word']
    grid = params['words'].split("")  
    base_url = "https://wagon-dictionary.herokuapp.com"
    endpoint = "/#{attempt}"
    url = base_url + endpoint
    file = open(url).read
    # paring the json so we can read it in ruby
    data = JSON.parse(file)
    attempt.upcase!
    attempt = attempt.split("") # => [h,o,u,s,e]
    # creating two hashes
    grid_hash = Hash.new(0)
    attempt_hash = Hash.new(0)
    # storing each letter into hash
    grid.map { |letter| grid_hash[letter] += 1 }
    attempt.map { |letter| attempt_hash[letter] += 1 }

    @display_attempt = params['created_word']
    @display_grid = grid.join(', ')

    attempt.each do |letter|
      if grid_hash[letter] < attempt_hash[letter]
        return @response = 'no build'
        return @response = "Sorry but #{params['created_word']} can’t be built out of #{grid.join(', ')}"
      end
    end
    if data['found']
      @response = 'valid'
      @score = (data["length"] ** 4) / (time_taken / 2)
    else @response = ""
    end
  end
end
