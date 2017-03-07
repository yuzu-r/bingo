class Game < ActiveRecord::Base
  after_create :initialize_firebase
  
  def random
    letters = self.word
    letter_count = letters.length
    range_per_column = self.range
    number_count = letter_count * range_per_column
    number_index = 1 + (rand * number_count).floor
    letter = letters[number_index / range_per_column]
    return letter + number_index.to_s
  end

  def call_number
    # check if there are any pieces left to select
    max_pieces = self.word.length * self.range
    pieces_drawn = JSON.parse(FB.get(game_uri).response.body)["numbers_drawn"]
    if pieces_drawn < max_pieces
      current_piece = self.random
      while !is_unique?(current_piece) 
        current_piece = self.random
      end
      FB.update(game_uri, 
        {status: 'active', current_piece: current_piece, numbers_drawn: pieces_drawn + 1})
      FB.push(game_uri + '/past_numbers/', current_piece)
      return true
    else
      FB.update(game_uri, {status: 'finished'})
      return false
    end
  end

  def is_unique?(current_piece)
    response_numbers = JSON.parse(FB.get(game_uri).response.body)["past_numbers"]
    number_list = response_numbers.nil? ? [] : response_numbers.values
    return !number_list.include?(current_piece)
  end

  def initialize_firebase
    FB.update(game_uri, {status: self.status, current_piece: "", numbers_drawn: 0})
  end

  def game_uri
    return '/games/' + self.id.to_s
  end

end