extends MeshInstance3D

@export var moon_distance : float = 100.0     # How far above the ground the moon orbits
@export var moon_size : float = 5.0           # Visual size of the moon
@export var max_brightness : float = 1.0      # How bright (visible) the moon gets at night

# Internal use
var base_color : Color = Color(0.8, 0.8, 0.9)

func _ready() -> void:
	scale = Vector3.ONE * moon_size
	if material_override == null:
		material_override = StandardMaterial3D.new()
	material_override.albedo_color = base_color
	material_override.unshaded = true

func _process(delta: float) -> void:
	var t = GlobalTime.time_of_day
	# Map time (0–24h) to full rotation
	var sun_angle_deg = ((t / 24.0) * 360.0) + 180
	var moon_angle_deg = sun_angle_deg + 180.0  # Opposite of sun

	# Convert to radians
	var angle_rad = deg_to_rad(moon_angle_deg)

	# Compute moon position in the sky
	var height = -sin(angle_rad) * moon_distance
	var forward = cos(angle_rad) * moon_distance
	global_position = Vector3(0, height, forward)

	# Smoothly fade visibility based on sun position
	var night_factor = clamp(abs(cos(deg_to_rad(sun_angle_deg))), 0.8, 1.0)
	material_override.albedo_color = base_color * night_factor * max_brightness
	
	if(t < 1 or t > 11):
		visible = true
	else:
		visible = false
