extends Node3D

var speed = 0.1
@onready var start_pos = self.position.y


func _process(delta: float) -> void:
	
	var t = GlobalTime.time_of_day
	if t:
		if(t >= 12 && t < 23):
			# stop it early so it doesn't go forever
			if(self.position.y >= start_pos-10):
				self.position.y = self.position.y - (t*delta*speed)
		elif(t < 12):
			if(self.position.y <= start_pos):
				self.position.y = self.position.y + (t*delta*speed)
