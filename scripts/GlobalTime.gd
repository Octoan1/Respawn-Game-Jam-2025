extends Node

# 0.0 -> 24.0 (hours)
var time_of_day : float = 6.0  # Start at 6 AM
var day_length : float = 60.0  # Seconds for a full day

func _process(delta: float) -> void:
	# Increase time based on day length
	time_of_day += (24.0 / day_length) * delta
	time_of_day = fmod(time_of_day, 24.0)  # Wrap around 24 hours
