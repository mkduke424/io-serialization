puts "--Hangman Game Started--"

# Pulls a random word from the 5desk.txt(dictionary of words) file that is between 5 and 12 charachters long 
def random_word
  lines = File.readlines("5desk.txt")
  arr_words = []
  lines.each do |word|
    # filter words between 5 and 12 letters long
    cleaned_word = word.chomp
    arr_words.push(cleaned_word) unless !cleaned_word.length.between?(5,12)
  end
   arr_words.sample(1)[0]
end

class HangMan 
 attr_accessor :word, :status, :incorrect_guesses
  def initialize(word) 
    @word = word
    @arr_word = word.split("")
    @status = []
    @arr_word.each do 
      @status.push("_")
    end
  
    @incorrect_guesses = []
  end

  def play_round
    puts "Guess a letter: "
    guessed_letter = gets.chomp.downcase

    # if the guessed letter isn't found in the chosen word then add it to incorrect guesses array
    @incorrect_guesses.push(guessed_letter) unless @arr_word.include? guessed_letter

    # if the guessed letter is found then update the status of the players correct guesses 
    @arr_word.each_with_index do |char, index|
      if char == guessed_letter
        @status[index] = char
      end
    end

    #output the progress of the player 
    p @status 
    p @incorrect_guesses
    p "You have #{ 6 - incorrect_guesses.length} incorrect guesses left"
  end
end

hangman = HangMan.new(random_word)

until hangman.incorrect_guesses.length == 6
  hangman.play_round

  # The winner is announced when the status doesn't contain "_" characters 
  unless hangman.status.include? '_'
    puts 'Congrats you have won!'
    break
  end
end

p "Sorry pal you lost the game! The word was: #{hangman.word} " if hangman.incorrect_guesses.length == 6
    


