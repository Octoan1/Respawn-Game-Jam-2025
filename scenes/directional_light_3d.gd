extends DirectionalLight3D

# How fast the sun moves (degrees per second)
@export var sun_speed: int

func _process(delta):
	# Rotate the sun around the X axis
	rotation_degrees.x += sun_speed * delta
	
	# Keep rotation in 0-360 degrees
	rotation_degrees.x = fmod(rotation_degrees.x, 360)
