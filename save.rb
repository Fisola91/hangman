class Save
  attr_reader :save_data
  def initialize
    @save_data = { save: [] }
  end

  def save_to_file(random_word, cryptic_letters, incorrect_cryptic_letter, attempt_left)
    new_data = {
      word: random_word,
      attempt_left: attempt_left,
      cryptic_letters: cryptic_letters,
      incorrect_cryptic_letter: incorrect_cryptic_letter
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

  def remove_from_record(index)
    existing_data = load_existing_file
    existing_data.delete_at(index)
    @save_data[:save] = existing_data
    File.open("save.json", "w") { |file| file.write(@save_data.to_json) }
  end

  def all_saves
    load_existing_file.each_with_index do |hash, index|
      puts "#{index}. Attempt_left: #{hash["attempt_left"]}, cryptic_letters: #{hash["cryptic_letters"]}, incorrect_cryptic_letters: #{hash["incorrect_cryptic_letter"]}"
    end
  end
end