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
  def initialize 
end

# for now lets practice with a random word - racecar - We can turn this into classes once we get the logic down

# creates the hangman word tracking template
word = "racecar"
arr_word = word.split("")
status = []
arr_word.each do 
  status.push("_")
end

incorrect_guesses = []

# play until the hangman is hung or until the correct letters are guess 
until incorrect_guesses.length == 6
#logic for gameplay
# Guess a letter
puts "Guess a letter: "
guessed_letter = gets.chomp.downcase
# if the guessed letter isn't found in the chosen word then add it to incorrect guesses array
incorrect_guesses.push(guessed_letter) unless arr_word.include? guessed_letter

# if the guessed letter is found then update the status of the players correct guesses 
arr_word.each_with_index do |char, index|
  if char == guessed_letter
    status[index] = char
  end
end
#output the progress of the player 
p status 
p incorrect_guesses

# quit if the status doesn't contain "-" symbol
if !status.include? "_"
  p "Congrats you won"
  break 
end

end

if incorrect_guesses.length == 6
  p "Sorry pal but you lost the game"
end








