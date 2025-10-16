extends Node3D

var code = [0,0,0]
var won = false
var moving = false
var gem_y = 0

func _ready() -> void:
	gem_y = self.get_child(0).global_position.y
	self.get_child(0).global_position.y += 50
	self.get_child(0).visible = false

func _process(delta: float) -> void:
	if(code[0] == 1 && code[1] == 2 && code[2] == 3 && !won):
		self.get_child(0).visible = true
		moving = true
		if(self.get_child(0).global_position.y > gem_y):
			self.get_child(0).global_position.y -= delta * 10
		else:
			won = true
