extends DirectionalLight3D
	
@export var sunrise_time : float = 0.0
@export var sunset_time : float = 12.0
@export var day_intensity : float = 1.0
@export var night_intensity : float = 0.5

@export var day_color : Color = Color(1.0, 0.95, 0.8)
@export var sunrise_color : Color = Color(1.0, 0.6, 0.3)
@export var sunset_color : Color = Color(1.0, 0.4, 0.2)
@export var night_color : Color = Color(0.1, 0.1, 0.2)

@export var sun_angle_offset : float

func _process(_delta: float) -> void:
	var t = GlobalTime.time_of_day

	# Rotate based on time of day (same as before)
	rotation_degrees.x = ((t / 24.0) * 360.0) + sun_angle_offset
	rotation_degrees.x = fmod(rotation_degrees.x, 360.0)

	# Calculate intensity and color
	var factor := _get_light_factor(t)
	light_energy = lerp(night_intensity, day_intensity, factor)
	light_color = _get_sun_color(t)
	
	if(t < sunrise_time or t > sunset_time):
		visible = false
	else:
		visible = true

func _get_light_factor(t: float) -> float:
	# Smooth fade in/out near sunrise/sunset
	if t < sunrise_time - 1 or t > sunset_time + 1:
		return 0.5  # Night
	elif t < sunrise_time + 1.0:
		return (t - sunrise_time) / 1.0  # Sunrise fade-in
	elif t > sunset_time - 1.0:
		return (sunset_time - t) / 1.0  # Sunset fade-out
	else:
		return 1.0  # Full day

func _get_sun_color(t: float) -> Color:
	if t < sunrise_time - 1 or t > sunset_time + 1:
		return night_color
	elif t < sunrise_time + 3.0:
		var f = (t - sunrise_time) / 3.0
		return sunrise_color.lerp(day_color, f)
	elif t > sunset_time - 3.0:
		var f = (sunset_time - t) / 3.0
		return sunset_color.lerp(day_color, f)
	else:
		return day_color
