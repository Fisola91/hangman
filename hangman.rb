require "json"
require 'active_support/inflector'
require_relative "random_word"
require_relative "save"

class Game
  attr_reader :max_attempt, :attempt, :new_game, :file

  def initialize(max_attempt: 10, file:)
    @random_word = RandomWord.random_word
    p @random_word
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
      cryptic_letters = "-" * @random_word.length
      puts "Correct letter will be displayed in the right position: #{cryptic_letters}"
    elsif File.size(file) > 0
      puts
      puts "choose from lists of saved game"
      existing_data = @save_instance.load_existing_file
      @save_instance.all_saves
      # existing_data.each_with_index do |hash, index|
      #   puts "#{index}. Attempt_left: #{hash["attempt_left"]}, cryptic_letters: #{hash["cryptic_letters"]}, incorrect_cryptic_letters: #{hash["incorrect_cryptic_letter"]}"
      # end
      puts
      print "choose: "
      choose = gets.chomp.to_i
      choosed_data = existing_data[choose]
      @save_instance.remove_from_record(choose)
      cryptic_letters = choosed_data["cryptic_letters"]
      incorrect_cryptic_letter = choosed_data["incorrect_cryptic_letter"]
      attempt = choosed_data["attempt_left"]
      @attempt = max_attempt - attempt
      @random_word = choosed_data["word"]
    else
      return "No saved data. Run the program again and press 1"
    end

    while @attempt < max_attempt
      puts
      attempt_left
      feedback(incorrect_cryptic_letter, cryptic_letters)
      print "Guess a letter: "
      guess = gets.chomp!

      if @random_word.include?(guess)
        puts
        if cryptic_letters.include?(guess)
          last_index_letter = cryptic_letters.rindex(guess)
          update_cryptic_letters(last_index_letter, guess, cryptic_letters)
        else
          letter_position = @random_word.index(guess)
          cryptic_letters[letter_position] = guess
        end

        @attempt += 1
      else
        puts
        p incorrect_cryptic_letter
        incorrect_cryptic_letter << guess
        feedback(incorrect_cryptic_letter,  cryptic_letters)
        @attempt += 1
      end

      # game_won(cryptic_letters)
      if  cryptic_letters.downcase == @random_word.downcase
        return "You win the game!"
      end
      puts "Do you want to save the game and leave?"
      puts "y/n"
      save_and_end = gets.chomp.include?("y")
      if save_and_end
        @save_instance.save_to_file(@random_word, cryptic_letters, incorrect_cryptic_letter, attempt_left)
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

  def update_cryptic_letters(last_index_letter, guess, cryptic_letters)
    random_word = @random_word.chars
    random_word.each_with_index do |letter, index|
      if index == last_index_letter
        substring = random_word[(last_index_letter + 1)..-1]
        break if substring.index(guess).nil?
        letter_position = last_index_letter + 1 + substring.index(guess)
        cryptic_letters[letter_position ] = guess
        break
      end
    end
  end

  # def game_won(cryptic_letters)
  #   if  cryptic_letters.downcase == @random_word.downcase
  #     return "You win the game!"
  #   end
  # end
end

game = Game.new(file: "save.json")
p game.start
