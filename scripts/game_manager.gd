extends Node

var gems_collected: Array[Node] 
var score: int = 0

func add_gem(gem: Node) -> void:
	if not gems_collected.has(gem):
		gems_collected.append(gem)
		score += 1
		print("Gem collected:", gem.name, ", Total gems:", gems_collected.size())
