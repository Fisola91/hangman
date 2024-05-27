# file  = File.new("google-10000-english-no-swears.txt")
# file_array = file.readlines
# code = file_array.sample.chomp!
# p code

# until code.length >= 5 && code.length <= 12
#   # p file_array.sample
#   code = file_array.sample.chomp!
#   p code
# end
# p code

class Game
  def initialize(file:, max_attempt: 10)
    @file = file
    @max_attempt = max_attempt
    @attempt = 0

    read_file = @file.readlines
    @code = read_file.sample.chomp!

    until @code.length >= 5 && @code.length <= 12
      @code = read_file.sample.chomp!
    end
  end

  def start
    incorrect_letters = []
    puts "Below is the number of letters to win the game in 10 attempts"
    correct_letters = "-" * code.length
    p "Correct letter will be displayed in the right position: #{correct_letters}"
    puts "..............."
    puts "..............."
    puts


    while @attempt < max_attempt
      puts
      if max_attempt - @attempt == 1
        puts " 1 attempt left"
      else
        puts "#{max_attempt - @attempt} attempts left"
      end
      puts "Inputed incorrect letters: #{incorrect_letters}"
      puts "correct letters: #{correct_letters}"
      print "Guess a letter: "
      guess = gets.chomp!
      if code.include?(guess)
        puts "letter #{guess.downcase} is correct"
        puts
        index_pos = code.index(guess)
        correct_letters[index_pos] = guess

        if correct_letters.downcase == code.downcase
          return "You won the game"
        end
        puts "Inputed incorrect letters: #{incorrect_letters}"
        puts "correct letters: #{correct_letters}"
        @attempt += 1
      else
        puts
        puts "guess letter not correct"
        incorrect_letters << guess
        puts "Inputed incorrect letters: #{incorrect_letters}"
        puts "correct letters: #{correct_letters}"
        @attempt += 1
      end
    end
    puts "You lost, the code is #{code.downcase}"
  end

  attr_reader :max_attempt, :attempt, :code
end

file = File.new("google-10000-english-no-swears.txt")
game = Game.new(file: file )
game.start
