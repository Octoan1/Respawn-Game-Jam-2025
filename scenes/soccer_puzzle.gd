extends Node3D

var code = [0,0,0,0]
var won = false
var moving = false
var gem_y = 0;

func _ready() -> void:
	var gem = self.get_child(-1)
	gem_y = gem.global_position.y

func _process(delta: float) -> void:
	var gem = self.get_child(-1)
	if(code[0] == 1 && code[1] == 2 && code[2] == 3 && code[3] == 4 && !won):
		moving = true
		if(gem.global_position.y < gem_y + 3):
			gem.global_position.y += delta * 0.5
		else:
			won = true
