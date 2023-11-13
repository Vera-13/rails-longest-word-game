require 'json'
require 'open-uri'
class GamesController < ApplicationController
  def new
    alph = ['A','B','C','D','E','F','G','H','L','M','N','O','P','Q','R','S','T','U','V','W','Y','Z']
    @letters = alph.sample(10)
  end

  def score
    @word = params[:user_input]
    @letters = params[:letters].split
    @result = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word = URI.open(@result).read
    @check_word = JSON.parse(word)
    @found = @check_word['found'];
    @includes = @word.chars.all? { |letter| @letters.include?(letter.upcase) }

    if @includes && @found
      @response = "Congratulations!#{@check_word['word']} is a valid English word!"
    elsif !@found
      @response = "Sorry but #{@check_word['word']} does not seem to be an English word..."
    elsif !@includes
      "Sorry but #{@check_word['word']} can not be build out of #{@letters}"
    end

    # if @check_word['found'] && @letters.include?(@check_word['word'])
    #   @response = "Congratulations!#{@check_word['word']} is a valid English word!"
    #   elseif !@letters.include?(@check_word['word'])
    #   @response = "Sorry but #{@check_word['word']} can not be build out of #{@letters}"
    # else
    #   @response = "Sorry but #{@check_word['word']} does not seem to be an English word..."
    # end
  end
end
