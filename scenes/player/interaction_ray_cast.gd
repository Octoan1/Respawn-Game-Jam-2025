extends RayCast3D

signal looking_at(target)
signal stopped_looking()

var wasLooking : bool = false
func _process(_delta: float) -> void:
	if is_colliding():
		wasLooking = true
		var new_target = get_collider().get_owner()
		looking_at.emit(new_target)
		#print("Looking at: ",new_target)
	elif wasLooking:
		wasLooking = false
		stopped_looking.emit()
		#print("Stopped looking")
