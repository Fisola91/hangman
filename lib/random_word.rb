module RandomWord
  def self.random_word
    file = File.new("google-10000-english-no-swears.txt")
    file_data = file.readlines
    word = file_data.sample.chomp!

    until word.length >= 5 && word.length <= 12
      word = read_file.sample.chomp!
    end
    word
  end
end