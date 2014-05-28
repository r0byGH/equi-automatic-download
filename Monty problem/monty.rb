#Monty Hall problem
noftests = 100
score_change, score_unchange = 0, 0
1.upto(noftests) do
	winning_door = rand(1..3)
	first_chosen_door =  rand(1..3)
	remaining_doors = [1, 2, 3]
	remaining_doors.delete(first_chosen_door)

	j = rand(2) #j is either 0 or 1
	if remaining_doors[j] == winning_door
		undeleted_door = winning_door
		remaining_doors.delete(winning_door)
		deleted_door = remaining_doors[0]
	else
		deleted_door = remaining_doors[j]
		remaining_doors.delete(deleted_door)
		undeleted_door = remaining_doors[0]
	end
	
	# if deleted_door == winning_door
		# deleted_door = undeleted_door
		# undeleted_door = winning_door
	# end if

	
	change_idea_chosen_door = undeleted_door
	unchange_idea_chosen_door = first_chosen_door

	if change_idea_chosen_door == winning_door
		score_change += 1
	end

	if unchange_idea_chosen_door == winning_door
		score_unchange += 1
	end
	
	puts "winning_door: " + winning_door.to_s
	puts "first_chosen_door: " + first_chosen_door.to_s
	puts "deleted_door: " + deleted_door.to_s
	puts "change_idea_chosen_door: " + change_idea_chosen_door.to_s
	puts "unchange_idea_chosen_door: " + unchange_idea_chosen_door.to_s
	puts ""
end

puts "score_change: #{score_change} out of #{noftests}"
puts "score_unchange: #{score_unchange} out of #{noftests}"




#OPERAZIONI POST SCARICO
#uncompress di tutti i files

#crea unico file di testo




