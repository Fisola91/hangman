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