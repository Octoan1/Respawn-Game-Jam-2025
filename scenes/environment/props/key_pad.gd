extends Node3D

var code = [0, 0, 0]
var won = false
var key_pad_y = 0
var gem_y = 0

func _ready() -> void:
	key_pad_y = self.global_position.y
	gem_y = self.get_parent().get_child(0).global_position.y
	
func _process(delta: float) -> void:
	if(code[0] == 4 && code[1] == 2 && code[2] == 7 && !won):
		if(self.global_position.y > key_pad_y - 1):
			self.global_position = self.global_position - Vector3(0, delta * 0.5, 0)
		elif(self.get_parent().get_child(0).global_position.y < gem_y + 2):
			self.get_parent().get_child(0).global_position = self.get_parent().get_child(0).global_position + Vector3(0, delta * 0.5, 0)
		else:
			won = true
	
