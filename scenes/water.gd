extends MeshInstance3D

var water_y = 0

func _ready() -> void:
	water_y = self.global_position.y
	
func _process(delta: float) -> void:
	var t = GlobalTime.time_of_day
	
	if(t == 0):
		self.global_position.y = water_y
	self.global_position.y -= 24 / (GlobalTime.day_length - 1) * delta
