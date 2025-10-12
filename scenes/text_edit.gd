extends TextEdit

func _process(delta: float) -> void:
	text = str(GlobalTime.day_counter) + str(GlobalTime.time_of_day)
	
