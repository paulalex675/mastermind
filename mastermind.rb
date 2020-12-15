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
        puts 'Congratulations you cracked my code!'
        puts 'You clever clogs'
        exit
      else puts "That's not quite right"
        if @num_guesses > 0
            puts 'Guess again'
            turn()
        else puts 'You failed to crack my code, tough luck!'
            print $code
        end
      end
    end
  end

  def master_code_breaker
    @my_f_back = Array.new
    while @guess != $code || @num_guesses > 0  
      if @num_guesses == 12 
        puts "Ok, here's my first guess"
        2.times { @guess << 'r' }
        2.times { @guess << 'g' }
        puts @guess
        @num_guesses -= 1
        puts 'How did I do?'
        puts 'Feedback is given with i for a correct color and position, x for a correct color 
        and incorrect position and 0 for incorrect color and position. Feedback should be 4 characters long'
        @my_f_back << gets.chomp.upcase.split('')
        @my_f_back.flatten!
        if @guess == $code || @my_f_back.join('') == 'IIII'
          print $code
          puts 'Yay! I did it!'
          puts "They Don't call me Mastermind for nothing you know!"
          exit
        end
      elsif @num_guesses < 12 && @num_guesses > 0
        puts "OK, here's my next guess"
        @my_f_back.flatten!
        @my_f_back.each_index do |a| if @my_f_back[a] == 'X'
                                       1.times { @guess << @guess.sample }
                                     elsif @my_f_back[a] == 'I'
                                       @guess << @guess[a]
                                     elsif @my_f_back[a] == '0'
                                       1.times { @guess << $colors.sample }
                                     else puts 'feedback error'
                                     end
                              end
        @my_f_back.clear
        @guess.flatten!
        4.times { @guess.delete_at(0) }
        puts @guess
        @num_guesses -= 1
        puts 'How did I do?'
        @my_f_back << gets.chomp.upcase.split('')
        if @guess == $code || @my_f_back.join('') == 'IIII'
          print $code
          puts 'Yay! I did it!'
          puts "They Don't call me Mastermind for nothing you know!"
          exit
      elsif @num_guesses == 1
        puts 'Ok, final guess. Is this your code?'
        @my_f_back.flatten!
        @my_f_back.each_index do |a| if @my_f_back[a] == 'X'
                                       1.times { @guess << @guess.sample }
                                     elsif @my_f_back[a] == 'I'
                                       @guess << @guess[a]
                                     elsif @my_f_back[a] == '0'
                                       1.times { @guess << $colors.sample }
                                     else puts 'feedback error'
                                     end
                              end
        @my_f_back.clear
        @guess.flatten!
        4.times { @guess.delete_at(0) }
        puts @guess
        @num_guesses -= 1
        puts 'How did I do?'
        @my_f_back << gets.chomp.upcase.split("")
        if @guess == $code || @my_f_back.join("") == "IIII"
          print $code
          puts 'Yay! I did it!'
          puts "They Don't call me Mastermind for nothing you know!"
          exit
        else puts 'Congratulations, your code was too difficult for me to crack!'
          exit
        end
        end
      end
    end
  end

  def feedback()
    @f_back.clear
    @guess.each_index do |a| if @guess[a] === $code[a]
                              @f_back << 'I'
                             elsif @guess.each { |b| $code.include? b }
                                  @f_back << 'X'
                             else @f_back << '0'
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
    $code.flatten!
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
  mastermind.master_code_breaker
else puts "Please type 'guess' or 'create'"
  @answer = gets.chomp
end