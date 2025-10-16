extends MeshInstance3D

var flipped = false

func _process(_delta: float) -> void:
	var t = GlobalTime.time_of_day
	if(t < 6 && flipped):
		flipped = false
		scale.x = scale.x * -1
	if(t >= 6 && !flipped):
		flipped = true
		scale.x = scale.x * -1
		
