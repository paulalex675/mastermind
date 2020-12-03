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
            @num_guesses -= 1
            feedback()
        end
    end

    def feedback
        a = 0
        @f_back.clear
        while a < $code.length
            if $code[a] === @guess[a]
                @f_back << $code[a]
            else @f_back << "*"
            end
            a += 1
        end
        puts $code 
        puts @guess
        print @f_back
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
      puts $code
      puts "Your code contains a combination of the colors red, green and blue"
    end
end

puts "Hello, I'm Mastermind!"
puts "What is your name?"
player1 = Player.new(gets.chomp)
puts "I bet you can't crack my colorful code"
puts "#{player1.name} how long would like the code to be?"
Code.new
player1.add_guesses
player1.turn


