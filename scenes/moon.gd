extends DirectionalLight3D

var moon_angle_offset : float = -90.0


func _process(delta: float) -> void:
	var t = GlobalTime.time_of_day
	rotation_degrees.x = ((t / 24.0) * 360.0) + moon_angle_offset

	# Calculate visibility smoothly based on time
	var sun_angle = ((t / 24.0) * 360.0) - 90.0
	
