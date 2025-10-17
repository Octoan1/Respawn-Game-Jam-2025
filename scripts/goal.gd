extends Node3D

@export var goal_num : int
var arch_x = 0
var arch_z = 0
var inside = false

func _ready() -> void:
	arch_x = self.global_position.x
	arch_z = self.global_position.z
	
func _process(_delta: float) -> void:
	var tumbleweed = self.get_parent().get_child(0).get_child(0)
	var tumbleweed_x = tumbleweed.global_position.x
	var tumbleweed_z = tumbleweed.global_position.z
	
	if(tumbleweed_x > arch_x - 4 && tumbleweed_x < arch_x + 4 && tumbleweed_z > arch_z - 1 && tumbleweed_z < arch_z + 1 && !inside && !self.get_parent().moving):
		inside = true
		self.get_parent().code[0] = self.get_parent().code[1]
		self.get_parent().code[1] = self.get_parent().code[2]
		self.get_parent().code[2] = self.get_parent().code[3]
		self.get_parent().code[3] = goal_num
		print(goal_num, " was added")
		print(self.get_parent().code)
		print()
	if(tumbleweed_x < arch_x - 4 || tumbleweed_x > arch_x + 4 || tumbleweed_z < arch_z - 1 || tumbleweed_z > arch_z + 1):
		inside = false
	
