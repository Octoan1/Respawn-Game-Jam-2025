extends Node

@onready var world_env: WorldEnvironment = $"../WorldEnvironment"
var env: Environment

var day_color: Color = Color(0.6, 0.8, 1.0)    # light blue
var night_color: Color = Color(0.05, 0.05, 0.2) # dark blue

var horizon_day: Color = Color(0.6, 0.8, 1.0)          # light blue
var horizon_sunrise: Color = Color(1.0, 0.6, 0.3)     # orange/pink
var horizon_sunset: Color = Color(1.0, 0.4, 0.2)      # deeper orange/red
var horizon_night: Color = Color(0.05, 0.05, 0.1)     # dark

func _ready() -> void:
	env = world_env.environment
	
	
func _process(_delta: float) -> void:
	var t = GlobalTime.time_of_day  # 0 - 24
	var factor: float

	# simple day/night factor
	if t > 12:
		factor = 0.0  # night
	elif t < 6:
		factor = (t - 0) / 6.0  # morning
	else:
		factor = 1.0 - ((t - 6) / 6.0)  # evening
	var color = night_color.lerp(day_color, factor)
	env.sky.sky_material.sky_top_color = color
	
	env.sky.sky_material.sky_horizon_color = get_horizon_color(t)
	
func get_horizon_color(t: float) -> Color:
	if t >= 0 and t < 3:  # sunrise -> day
		var f = (t - 0) / 3.0
		return horizon_sunrise.lerp(horizon_day, f)
	elif t >= 3 and t < 9:  # day -> sunset
		var f = (t - 3) / 6.0
		return horizon_day.lerp(horizon_sunset, f)
	elif t >= 9 and t < 12:  # sunset -> night
		var f = (t - 9) / 3.0
		return horizon_sunset.lerp(horizon_night, f)
	elif t >= 21  and t < 24:  # night -> sunrise
		var f = (t - 21) / 3.0
		return horizon_night.lerp(horizon_sunrise, f)
	else:
		return horizon_night
