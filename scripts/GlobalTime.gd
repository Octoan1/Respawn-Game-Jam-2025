extends Node

# 0.0 -> 24.0 (hours)
var time_of_day : float = 0.0  # Start at 6 AM
var day_length : float = 3 * 60.0  # Seconds for a full day
var day_counter : int = 0
var stopped : bool = false

func _process(delta: float) -> void:
	# Increase time based on day length
	if(!stopped):
		time_of_day = fmod(time_of_day, 24.0)  # Wrap around 24 hours
		time_of_day += (24.0 / day_length*2) * delta
		if(time_of_day >= 24):
			day_counter += 1
