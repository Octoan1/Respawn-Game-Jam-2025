extends DirectionalLight3D

# How fast the sun moves (degrees per second)
#@export var sun_speed: int

#func _process(delta):
	# Rotate the sun around the X axis
	#rotation_degrees.x += sun_speed * delta
	
	# Keep rotation in 0-360 degrees
	#rotation_degrees.x = fmod(rotation_degrees.x, 360)
	
# Maximum sun rotation (0° = sunrise, 180° = sunset)
@export var sun_angle_offset : float = 180 # Adjust so sun starts below horizon

func _process(delta: float) -> void:
	# Map time_of_day (0-24) to rotation
	# 6 AM -> 0°, 18 PM -> 180°, 0-6 & 18-24 below horizon
	var t = GlobalTime.time_of_day
	rotation_degrees.x = ((t / 24.0) * 360.0) + sun_angle_offset
