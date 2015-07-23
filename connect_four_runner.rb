require_relative 'connect_four_game'

## CONNECT FOUR RUNNER ##

# if you want to play with a diffferent board size
# you must swap out "print new_game" with "new_game.print_board"

new_game = Game.new(6,7)

puts "Welcome to Jason's Connect Four"
puts "Here is your Connect Four Board"
sleep(3)

while !new_game.game_over

  system("clear")
  print new_game
  puts "Player 1's move"
  puts "Which column would you like to place your chip?"
  column1 = gets.chomp
  new_game.move(1,column1.to_i)
  if new_game.game_over
    print new_game
    puts "Please restart ruby file to play again!"
    break
  end

  system("clear")
  print new_game
  puts "Player 2's move"
  puts "Which column would you like to place your chip?"
  column2 = gets.chomp
  new_game.move(2,column2.to_i)
  if new_game.game_over
    print new_game
    puts "Please restart ruby file to play again!"
    break
  end

end