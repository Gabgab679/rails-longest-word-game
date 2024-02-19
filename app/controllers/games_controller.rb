require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:answer]}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)

    attempt = params[:answer].upcase.split('')
    new_letters = params[:letters].split(' ')
    # on va itérer sur attempt pour voir si la new letter appartient
    result = attempt.all? { |letter| new_letters.include?(letter) }
    if result == false
      @score = "Le mot ne peut pas être créé à partir de la grille dorigine"
    elsif user["found"] == false
      @score = 'Le mot est valide daprès la grille, mais ce nest pas un mot anglais valide.'
    else
      @score = 'Le mot est valide daprès la grille et est un mot anglais valide.'
    end
  end
end


# Le mot ne peut pas être créé à partir de la grille d’origine.
# Le mot est valide d’après la grille, mais ce n’est pas un mot anglais valide.
# Le mot est valide d’après la grille et est un mot anglais valide.


# {"authenticity_token"=>"[FILTERED]", "letters"=>"I U M C V R N Z Q H", "answer"=>"azklfnmkn"}

# >> attempt
# => ["F", "S", "N", "C", "F", "Q", "K", "S", "J"]
# >> new_letters
# => ["D", "P", "R", "Z", "K", "W", "I", "M", "L", "X"]
