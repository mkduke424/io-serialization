puts "--Hangman Game Started--"
require 'yaml'

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
 attr_accessor :word, :status, :incorrect_guesses, :arr_word
  def initialize(word) 
    @word = word
    @arr_word = word.split("")
    @status = []
    @arr_word.each do 
      @status.push("_")
    end
  
    @incorrect_guesses = []
  end

  def save_file
    save_line = YAML.dump({
      :word => @word,
      :arr_word => @arr_word,
      :status => @status,
      :incorrect_guesses => @incorrect_guesses
    })

    save_file = File.open("save.txt","w")
    save_file.puts save_line
    save_file.close
    puts "we have now saved your game"
  end

  def load_file
    saved_file = File.open("save.txt", "r")
    saved_line = saved_file.read
    instance_variables = YAML.load saved_line
    @word = instance_variables[:word]
    @arr_word = instance_variables[:arr_word]
    @status = instance_variables[:status]
    @incorrect_guesses = instance_variables[:incorrect_guesses]
    puts "we have loaded your saved game"
    p @status
    p @incorrect_guesses
  end

  def play_round
    puts "Guess a letter or press 1 to save your progress: "
    guessed_letter = gets.chomp.strip.downcase
    if guessed_letter == "1"
      save_file
      exit(true)
    end
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
puts "Do you want to lead in your previously saved game? - Y for yes or press any other key for no"
response = gets.chomp.downcase
if response == "y"
hangman = HangMan.new(random_word)
hangman.load_file
else
  hangman = HangMan.new(random_word)
  p hangman.status
end

until hangman.incorrect_guesses.length == 6
  hangman.play_round
  
  # The winner is announced when the status doesn't contain "_" characters 
  unless hangman.status.include? '_'
    puts 'Congrats you have won!'
    break
  end
end

p "Sorry pal you lost the game! The word was: #{hangman.word} " if hangman.incorrect_guesses.length == 6
    


