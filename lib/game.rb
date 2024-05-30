require "json"
require 'active_support/inflector'
require_relative "random_word"
require_relative "save"

class Game
  attr_reader :max_attempt, :attempt, :new_game, :file

  def initialize(file: "save.json", random_word:, max_attempt: 10)
    @random_word = random_word
    @max_attempt = max_attempt
    @attempt = 0
    @file = file
    @save_instance = Save.new
    puts "Start a new game? press 1 / Choose a saved game? press 2"
    @choice = gets.chomp!
    @new_game = @choice.to_s.include?("1")
  end

  def start
    if new_game
      incorrect_cryptic_letter = []
      puts "Below is the number of letters to win the game in 10 attempts"
      encoded_words = "-" * @random_word.length
      puts "Correct letter will be displayed in the right position: #{encoded_words}"
    elsif File.size(file) > 0
      puts
      puts "choose from lists of saved game"
      existing_data = @save_instance.load_existing_file
      @save_instance.all_saves
      puts
      print "choose: "
      choose = gets.chomp.to_i
      chose_data = existing_data[choose]
      @save_instance.remove_from_record(choose)
      encoded_words = chose_data["encoded_words"]
      incorrect_cryptic_letter = chose_data["incorrect_cryptic_letter"]
      attempt = chose_data["attempt_left"]
      @attempt = max_attempt - attempt
      @random_word = chose_data["word"]
    else
      return "No saved data. Run the program again and press 1"
    end

    while @attempt < max_attempt
      puts
      attempt_left
      feedback(incorrect_cryptic_letter, encoded_words)
      print "Guess a letter: "
      guess = gets.chomp!

      if @random_word.include?(guess)
        puts
        if encoded_words.include?(guess)
          last_index_letter = encoded_words.rindex(guess)
          update_encoded_words(last_index_letter, guess, encoded_words)
        else
          letter_position = @random_word.index(guess)
          encoded_words[letter_position] = guess
        end

        @attempt += 1
      else
        puts
        # puts incorrect_cryptic_letter
        incorrect_cryptic_letter << guess
        feedback(incorrect_cryptic_letter,  encoded_words)
        @attempt += 1
      end

      if  encoded_words.downcase == @random_word.downcase
        return "You win the game!"
      end
      puts "Do you want to save the game and leave?"
      puts "y/n"
      save_and_end = gets.chomp.include?("y")
      if save_and_end
        @save_instance.save_to_file(@random_word, encoded_words, incorrect_cryptic_letter, attempt_left)
        return "Data saved, bye!"
      end
    end
    "You lost, the random_word is #{@random_word.downcase}"
  end


  private

  def feedback(incorrect_letters, correct_letters)
    puts "Inputed incorrect letters: #{incorrect_letters}"
    puts "correct letters: #{correct_letters}"
  end

  def attempt_left
    attempt_left = max_attempt - @attempt
    puts attempt_left ? "#{attempt_left} #{'attempt'.pluralize(attempt_left)} left" : nil
    attempt_left
  end

  def update_encoded_words(last_index_letter, guess, encoded_words)
    random_word = @random_word.chars
    random_word.each_with_index do |letter, index|
      if index == last_index_letter
        substring = random_word[(last_index_letter + 1)..-1]
        break if substring.index(guess).nil?
        letter_position = last_index_letter + 1 + substring.index(guess)
        encoded_words[letter_position ] = guess
        break
      end
    end
  end
end

