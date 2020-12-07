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
        puts "How many guesses do you think you can crack it in?"
        puts "I'll give you some feed back on how good each guess was"
        @num_guesses = gets.chomp.to_i
    end

    def turn
        while @num_guesses > 0
            puts "Please take a guess, r for red, g for green, b for blue"
            puts "You have #{@num_guesses} guesses left"
            @guess.clear
            @guess << gets.chomp.split("") 
            @guess.flatten!
            @num_guesses -= 1
            feedback()
            if @guess == $code || @f_back == $code
                puts "Congratulations you cracked my code!"
                puts "You clever clogs"
                exit
            else puts "That's not quite right"
                if @num_guesses > 0
                    puts "Guess again"
                    turn()
                else puts "You failed to crack my code, tough luck!"
                end
            end
        end
    end

    def feedback
        a = 0
        @f_back.clear
        while a < $code.length
            if $code[a] == @guess[a]
                @f_back << $code[a]
            else @f_back << "*"
            end
            a += 1
        end
        print  @f_back
    end

end

class Code
    attr_accessor :code
    def initialize
      @colors = ["r", "g", "b"]
      $code = code
      code_generator()
    end

    def code_generator()
      $code = Array.new
      x = gets.chomp.to_i
      x.times { $code << @colors.sample }
      puts "Your code contains a combination of the colors red, green and blue"
    end
end

puts "Hello, I'm Mastermind!"
puts "What is your name?"
player1 = Player.new(gets.chomp)
puts "I bet you can't crack my colorful code"
puts "#{player1.name} the code will be 4 digits long and will be a combination of 6 possible colours"
Code.new
player1.add_guesses
player1.turn


