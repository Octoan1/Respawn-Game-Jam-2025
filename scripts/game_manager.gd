extends Node

signal display_gem(gem)
signal all_gems_collected()

var gems_collected: Array[Gem] 
var score: int = 0
const MAX_SCORE = 3


func add_gem(gem: Gem) -> void:
	if not gems_collected.has(gem):
		gems_collected.append(gem)
		score += 1
		if score <= 16:
			display_gem.emit(gem)
		else: 
			print("stop collecting gems idiot you already won")
		print("Gem collected:", gem.name, ", Total gems:", gems_collected.size())
	
	# When max reached, emit signal
	if score == MAX_SCORE:
		print("All gems collected! Opening pyramid door...")
		all_gems_collected.emit()
		
func end_game():
	print("game is ending now")
	
	
	
	

		
