class Player
  attr_accessor :name, :num_guesses, :guess, :f_back
  def initialize(name)
    @name = name
    @num_guesses = num_guesses
    @guess = Array.new
    @num_guesses = 12
    @f_back = Array.new
  end

  def turn
    while @num_guesses > 0
      puts "Please take a guess, type 'r' for red, 'o' for orange, 'y' for yellow, 'g' for green, 
      'b' for blue and 'p' for purple"
      puts "You have #{@num_guesses} guesses left"
      @guess.clear
      @guess << gets.chomp.split("") 
      @guess.flatten!
      @num_guesses -= 1
      feedback()
      if @guess == $code || @f_back == $code
        print $code
        puts "Congratulations you cracked my code!"
        puts "You clever clogs"
        exit
      else puts "That's not quite right"
        if @num_guesses > 0
            puts "Guess again"
            turn()
        else puts "You failed to crack my code, tough luck!"
            print $code
        end
      end
    end
  end

  def code_breaker
    @my_f_back = Array.new
    while @num_guesses > 0
      puts "So here is my guess"
      @guess.clear
      4.times { @guess << $colors.sample } 
      @guess.flatten!
      @num_guesses -= 1
      puts @guess
      puts "How did I do?"
      @my_f_back << gets.chomp.split("")
      if @guess == $code || @my_f_back.join("") == "IIII"
      print $code
      puts "Yay! I did it!"
      puts "They Don't call me Mastermind for nothing you know!"
      exit
      else puts "Hmm let me have another go"
        if @num_guesses > 0
          puts "Guess again"
          code_breaker()
        else puts "Congratulations, your code was too tough for me to beat"
          print $code
        end
      end
    end
  end

  def feedback
    @f_back.clear
    @guess.each_index do |a| if @guess[a] === $code[a]
                              @f_back << "I"
                          elsif @guess.each { |b| $code.include? b }
                              @f_back << "X"
                          else @f_back << "0"
                          end
                  end
  print @f_back.shuffle
  end

end

class Code
  attr_accessor :code
  def initialize
    $colors = ["r", "o", "y", "g", "b", "p"]
    $code = code
  end

  def code_generator()
    $code = Array.new
    4.times { $code << $colors.sample }
    puts "Your 4 digit code contains a possible combination of the colors red, green, blue, yellow, purple and orange"
  end

  def create_code()
    $code = Array.new
    puts "create your code with a combination of 'r', 'g', 'b', 'y', 'o', 'p' and I'll guess it"
    puts "I won't peek, honest"
    $code << gets.chomp.split("")

  end
end

code = Code.new
mastermind = Player.new('Mastermind')
puts "Hello, I'm Mastermind!"
puts "What is your name?"
player1 = Player.new(gets.chomp)
puts "Hi #{player1.name}, Would you like to try and crack one of my colourful codes? or do you want to see if I can crack yours?"
puts "type 'guess' or 'create'"
@answer = gets.chomp
if @answer == 'guess'
  code.code_generator
  player1.turn 
elsif @answer == 'create'
  code.create_code
  mastermind.code_breaker
else puts "Please type 'guess' or 'create'"
  @answer = gets.chomp
end