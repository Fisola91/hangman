require "json"
module RandomWord
  def self.random_word
    file = File.new("google-10000-english-no-swears.txt")
    read_file = file.readlines
    sample = read_file.sample.chomp!

    until sample.length >= 5 && sample.length <= 12
      sample = read_file.sample.chomp!
    end
    sample
  end
end


class Save
  attr_reader :save_data
  def initialize
    @save_data = { save: [] }
  end

  def save_to_file(random_word, guess, attempt_left)
    # @save_data = { save: [] }
    # p File.exist?(file)
    @save_data = { save: [] }
    new_data = {
      word: random_word,
      attempt_left: attempt_left,
      guess: guess
    }

    if File.exist?("save.json") && File.size("save.json") > 0
      load_existing_file
    else
      @save_data = { save: [] }
    end
    @save_data[:save] << new_data
    File.open("save.json", "w") { |file| file.write(@save_data.to_json) }
  end

  def load_existing_file
    existing_data = JSON.parse(File.read("save.json"))
    @save_data[:save] = existing_data["save"]
  end
end

class Game
  attr_reader :max_attempt, :attempt, :new_game

  RANDOMWORD = RandomWord.random_word
  def initialize(max_attempt: 10, save:)
    @max_attempt = max_attempt
    @attempt = 0
    @save = save
    @save_instance = Save.new
    puts "Start a new game? press 1 / Choose a saved game? press 2"
    @choice = gets.chomp!
    @new_game = @choice.to_s.include?("1")
  end

  def feedback(incorrect_letters, correct_letters)
    puts "Inputed incorrect letters: #{incorrect_letters}"
    puts "correct letters: #{correct_letters}"
  end

  def attempt_left
    attempt_left = max_attempt - @attempt
    if attempt_left == 1
      puts " 1 attempt left"
    else
      puts "#{attempt_left} attempts left"
    end
    attempt_left
  end

  # def save_game?(correct_letters, attempt_left)
  #   # puts "Do you want to save the game and leave?"
  #   # puts "y/n"
  #   save_and_leave = gets.chomp.include?("y")
  #   if save_and_leave
  #     @save_instance.save_to_file(RANDOMWORD, correct_letters, attempt_left)
  #     string_json = @save_instance.save_data.to_json
  #     # File.write(@save, string_json, mode: 'w')
  #     File.open("save.json", "w") { |file| file.write(string_json) }
  #     # return "You can continue later. Bye!"
  #   end
  # end

  def update_guess_word(last_index_letter, guess, correct_letters)
    random_word = RANDOMWORD.chars
    random_word.each_with_index do |letter, index|
      if index == last_index_letter
        substring = random_word[(last_index_letter + 1)..-1]
        break if substring.index(guess).nil?
        index_pos = last_index_letter + 1 + substring.index(guess)
        correct_letters[index_pos] = guess
        break
      end
    end
  end

  def start
    if new_game
      # incorrect_letters
      incorrect_cryptic_letter = []
      puts "Below is the number of letters to win the game in 10 attempts"
      cryptic_letter = "-" * RANDOMWORD.length
      p "Correct letter will be displayed in the right position: #{cryptic_letter}"
    end

    while @attempt < max_attempt
      puts
      attempt_left
      feedback(incorrect_cryptic_letter, cryptic_letter)
      print "Guess a letter: "
      guess = gets.chomp!

      if RANDOMWORD.include?(guess)
        puts
        letter_position = RANDOMWORD.index(guess)
        if cryptic_letter.include?(guess)
          last_index_letter = cryptic_letter.rindex(guess)
          update_guess_word(last_index_letter, guess, cryptic_letter)
        else
          cryptic_letter[letter_position] = guess
        end

        @attempt += 1
      else
        puts
        incorrect_cryptic_letter << guess
        feedback(incorrect_cryptic_letter,  cryptic_letter)
        @attempt += 1
      end

      if  cryptic_letter.downcase == RANDOMWORD.downcase
        return "You win the game!"
      end
      puts "Do you want to save the game and leave?"
      puts "y/n"
      save_and_leave = gets.chomp.include?("y")
      if save_and_leave
        @save_instance.save_to_file(RANDOMWORD,  cryptic_letter, attempt_left)
        return "Data saved, bye!"
      end
    end
    puts "You lost, the RANDOMWORD is #{RANDOMWORD.downcase}"
  end
end

game = Game.new(save: "save.json")
p game.start
