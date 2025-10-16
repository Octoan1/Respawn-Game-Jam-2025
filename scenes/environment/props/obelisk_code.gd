extends Node3D

@export var rise_time : int
@export var sink_time : int
var hidden_y = 0.0

func _ready() -> void:
	hidden_y = self.global_position.y

func _process(delta: float) -> void:
	var t = GlobalTime.time_of_day
	if(t >= rise_time && t < sink_time):
		if(self.global_position.y < hidden_y + 10):
			self.global_position.y += delta * 2
	elif(t >= sink_time && self.global_position.y > hidden_y):
		self.global_position.y -= delta * 2
