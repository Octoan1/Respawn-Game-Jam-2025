extends Node3D

#var t = GlobalTime.time_of_day 
var speed = 0.03
@onready var start_pos = self.position.y


func _process(delta: float) -> void:
	
	var t = GlobalTime.time_of_day
	if t:
		if(t > 10 && t < 20):
			# stop it early so it doesn't go forever
			if(self.position.y <= start_pos+5):
				self.position.y = self.position.y + (t*delta*speed)
				
		elif(t > 20):
			if(self.position.y >= start_pos):
				self.position.y = self.position.y - (t*delta*speed)
