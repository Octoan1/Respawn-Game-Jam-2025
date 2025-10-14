extends Node3D

var t = GlobalTime.time_of_day 
var speed = 0.01
var start_pos = self.position.y

func _physics_process(delta: float) -> void:
	if t:
		# stop it early so it doesn't go forever
		if(self.position.y <= start_pos+5):
			self.position.y = self.position.y + (t*delta*speed)
