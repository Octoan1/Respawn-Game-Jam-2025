extends Control

func _pause(event: InputEvent)-> void:
	if event is InputEventKey:
		if event.is_action_pressed("pause") && is_visible():
			set_visible(false)
		else:
			set_visible(true)
