extends Node3D

@export var rise_time : int
@export var sink_time : int

func _process(delta: float) -> void:
	var t = GlobalTime.time_of_day
	if(t >= rise_time && t < sink_time):
		if(self.global_position.y < -9):
			self.global_position.y += delta * 0.5
		elif(t >= sink_time && self.global_position.y > -14.32):
			self.global_position.y -= delta * 0.5
