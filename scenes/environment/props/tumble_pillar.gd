extends Node3D

var pillar_y = 0

func _ready() -> void:
	pillar_y = self.global_position.y

func _process(delta: float) -> void:
	var t= GlobalTime.time_of_day
	if(t > 12 && t < 23):
		if(self.global_position.y > pillar_y - 11):
			self.global_position.y -= delta * 2
	elif(t > 23):
		if(self.global_position.y < pillar_y):
			self.global_position.y += delta * 2
