class Player
    attr_accessor :name, :num_guesses, :guess, :f_back
        def initialize(name)
        @name = name
        @num_guesses = num_guesses
        @guess = Array.new
        @num_guesses = 0
        @f_back = Array.new
    end

    def add_guesses
        puts "How many guesses do you think you can crack it in? (The standard amount is 12)"
        puts "You'll get a feedback array after each guess. 
          An 'I' will indicate you guessed one color and location correctly.
          An '0' will indicate a correct color but incorrect location. 
          An 'X' will indicate and incorrect color and location"
        @num_guesses = gets.chomp.to_i
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
      @colors = ["r", "o", "y", "g", "b", "p"]
      $code = code
      code_generator()
    end

    def code_generator()
      $code = Array.new
      4.times { $code << @colors.sample }
      puts "Your 4 digit code contains a possible combination of the colors red, green, blue, yellow, purple and orange"
    end
end

puts "Hello, I'm Mastermind!"
puts "What is your name?"
player1 = Player.new(gets.chomp)
puts "Hi #{player1.name}, I bet you can't crack my colorful code, I've made it just for you!"
Code.new
player1.add_guesses
player1.turn


