extends Node3D

var water_x = 0
var water_z = 0
var water_y = 0
var gem : Node

func _ready() -> void:
	water_x = self.get_parent().get_child(0).global_position.x
	water_z = self.get_parent().get_child(0).global_position.z
	gem = self.get_parent().get_child(-1)
	gem.visible = false
	
func _process(_delta: float) -> void:
	water_y = self.get_parent().get_child(0).global_position.y
	gem = self.get_parent().get_child(-1)
	var distance = sqrt((self.get_child(0).global_position.x - water_x)**2 + (self.get_child(0).global_position.z - water_z)**2)
	if(distance < 75 && self.get_child(0).global_position.y <= water_y + 23):
		gem.global_position = self.get_child(0).global_position
		gem.visible = true
		queue_free()
