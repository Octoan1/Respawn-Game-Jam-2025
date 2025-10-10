extends MeshInstance3D

var day_color : Color = Color(0.8, 0.8, 1.0)   # Light blue
var night_color : Color = Color(0.1, 0.1, 0.3) # Dark blue

func _ready() -> void:
	# Ensure the box has a material
	if material_override == null:
		material_override = StandardMaterial3D.new()

func _process(delta: float) -> void:
	var t = GlobalTime.time_of_day
	# Simple mapping: 6-18 = day, else night
	if t >= 6.0 and t < 18.0:
		material_override.albedo_color = day_color
	else:
		material_override.albedo_color = night_color
	rotation_degrees.x = ((t / 24.0) * 360.0)
