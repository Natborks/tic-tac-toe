class Game
	$my_hash = {:row1=> {"a1"=>"_","a2"=>"_","a3"=>"_"},:row2=>{"b1"=>"_","b2"=>"_","b3"=>"_"},:row3=>{"c1"=>"_","c2"=>"_","c3"=>"_"}}
		
	def initialize
		give_instructions
		 Game.draw($my_hash)
	end 
	
	def give_instructions
		puts "Type \'a\' for top row, \'b\' for middle row and \'c\' for bottom row."
		puts "Then type \'1\' for first column, \'2\' for second column and \'3\' for third column."
		puts "E.g. \"b3\" would add your mark to the third row in the middle column.\n\n"
	end
	def self.check_hash(played_value)
			if ($my_hash[:row1][played_value] == "_")
					return true
			elsif ($my_hash[:row2][played_value] == "_")
					return true
			elsif ($my_hash[:row3][played_value] == "_")
					return true			
			else
					return false
			end		
	end
	
	def self.set_hash(player,played_value,hash)
		
	hash_state = check_hash(played_value)	
		if hash_state == true
			if player == "a"
				if played_value[0] == "a"
					$my_hash[:row1][played_value] = "X"
				elsif played_value[0] == "b"
					$my_hash[:row2][played_value] = "X"
				else
					$my_hash[:row3][played_value] = "X"
			    	end
			else
				if played_value[0] == "a"
					$my_hash[:row1][played_value] = "0"
				elsif played_value[0] == "b"
					$my_hash[:row2][played_value] = "0"
				else
					$my_hash[:row3][played_value] = "0"
				end
			end
			$played = true
		else
			print "invalid move"
			$played = false
		end	
		 draw($my_hash)
	end

	def self.draw(my_hash)

		my_hash.each do |k,v|
			print "\n"
			v.each do |k1,v1|
					print " | " if (k1[1] == "2" || k1[1] == "3")
					print "_" + v1 +"_ "
			end

			print "\n"
			v.each do |k1,v1|
				print " | " if (k1[1] == "2" || k1[1] == "3")
				print " " + " " +"  "
			end
		
		end
		print "\n\n"
	end

	def self.stalemate(hash)
			stale = 9
		hash.each do |k,v|
			v.each_value do |v1|
				if v1 != "_"
					stale =stale-1
				end			
			end
		end
		if stale == 0
			return true
		else
			return false
		end
	end
	
	def self.won(hash)
	#check for winining configuration and set $win to true
		win_array = Array.new
		hash.each do |k,v|
				v.each_value do |v1|
					win_array.push(v1)
				end	
		end
		if ((win_array[0] == win_array[1]) && (win_array[0] == win_array[2])) && (win_array[0]!= "_")
			$win = true 
		 elsif ((win_array[3] == win_array[4]) && (win_array[3] == win_array[5])) && (win_array[3] != "_")
			$win = true
		 elsif ((win_array[6] == win_array[7]) && (win_array[6] == win_array[8])) && (win_array[6] != "_" )
			$win = true
		 elsif ((win_array[0] == win_array[3]) && (win_array[0] == win_array[6])) && (win_array[0] != "_")
			$win = true 
		 elsif ((win_array[1] == win_array[4]) && (win_array[1] == win_array[7])) && (win_array[1] != "_")
			$win = true
		 elsif ((win_array[2] == win_array[5]) && (win_array[2] == win_array[8])) && (win_array[2] != "_")
			$win = true
		 elsif ((win_array[0] == win_array[4]) && (win_array[0] == win_array[8])) && (win_array[0] != "_")
			$win = true
		 elsif ((win_array[2] == win_array[4]) && (win_array[2] == win_array[6])) && (win_array[2] != "_")
			$win = true
		end
	end
	
end


class Player
	def initialize; end

	def play
		move = gets.chomp
		if move.length == 2 
			if move[0] == "a" && move[1].match(/["1","2","3"]/) 
				return move
			elsif move[0] == "b" && move[1].match(/["1","2","3"]/)
				return move
			elsif move[0] =="c" && move[1].match(/["1","2","3"]/)
				return move 
			else
				print "invalid move: "
				play
			end
		else
			print "invalid move: "
				play
		end	
	end
end

$win = false
$played = false
game = Game.new
while ($win != true) 
	player1 = Player.new
	player2 = Player.new
	
	while $played != true
	print "player 1 play: "
	a = player1.play
	Game.set_hash("a",a,$my_hash)
	Game.won($my_hash)
		 if $win == true
			print "player1 won\n"
			exit
		end
	end

	if Game.stalemate($my_hash) == true
		print "stalemate\n"
		exit
	end

	$played = false
	
	while $played != true
	print "player 2 play: "
	b = player2.play
	Game.set_hash("b",b,$my_hash)
	Game.won($my_hash)
		 if $win == true
			print "player2 won\n"
			exit
		end
	end
	if Game.stalemate($my_hash) == true
		print "stalemate\n"
		exit
	end
	$played = false
end
