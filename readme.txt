This is a simple a basic tic-tac-toe game. You can read the description of how to play at https://en.wikipedia.org/wiki/Tic-tac-toe. As usual, this is my poor man's implementationo using ruby. Hope you enjoy.


module Player_auth
puts "Whom do you want to play against? Player or AI"
opponent = gets.chomp
if opponent.downcase == "ai"
	puts "Sorry. Unfortunately, ai functionality hasn't been developed yet. Wouldn't you like to play against another player?"
		opponent = gets.chomp
else
   	puts "Sorry invalid player" unless opponent.downcase == "player"
end
end	
